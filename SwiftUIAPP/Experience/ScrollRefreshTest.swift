//
//  ScrollRefreshTest.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI

struct ScrollRefreshTest: View {
    var body: some View {
        VStack {
            
            let text = """
               网络请求错误信息展示可以借用第三方 Toast 展示
               """
            Text(text)
            
            NavigationLink("列表刷新") {
                ScrollRefreshTest01(vm: ScrollRefreshTest01.ViewModel())
            }
            
            NavigationLink("详情刷新") {
                ScrollRefreshTest02(vm: ScrollRefreshTest02.ViewModel())
            }
            
        }
    }
}


struct ScrollRefreshTest01: View {
    
    @MainActor // 保证 viewmodel 属性变化发生在主线程
    class ViewModel: ObservableObject {
        
        // MARK: - extern
        
        var typeId = -1 // 表示全部或者默认推荐
        
        // MARK: - data
        
        @Published var isLoadingData = false
        var currentIndex = 0
        
        @Published var noMoreData = false
        @Published var orderList: [String] = []
        
        // MARK: - load
        func loadData() async { // 在其中刷新 list
            isLoadingData = true
            currentIndex = 0
            let list = await withCheckedContinuation { continuatino in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    guard let strongself = self else {
                        continuatino.resume(returning: [String]())
                        return
                    }
                    let list = (1...10).map { i in
                        "第\(i + strongself.currentIndex * 10)项"
                    }
                    continuatino.resume(returning: list)
                }
            }
            noMoreData = list.count < 10
            orderList = list
            isLoadingData = false
        }
        
        func loadMore() async { // 在其中刷新 list
            isLoadingData = true
            currentIndex += 1
            let list = await withCheckedContinuation { continuatino in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    guard let strongself = self else {
                        continuatino.resume(returning: [String]())
                        return
                    }
                    var list: [String] = []
                    if strongself.currentIndex == 2 {
                        list = (1...7).map { i in
                            "第\(i + strongself.currentIndex * 10)项"
                        }
                    } else {
                        list = (1...10).map { i in
                            "第\(i + strongself.currentIndex * 10)项"
                        }
                    }
                    continuatino.resume(returning: list)
                }
            }
            noMoreData = list.count < 10
            orderList += list
            isLoadingData = false
        }
        
    }
    
    @StateObject var vm: ViewModel
    @Environment(\.isPresented) var isPresented
    
    var body: some View {
        VStack {
            Divider()
            ScrollView {
                LazyVStack {
                    ForEach(0..<vm.orderList.count, id: \.self) { index in
                        Button(vm.orderList[index]) {
                            print(vm.orderList[index])
                        }
                        .frame(height: 44)
                    }
                    ZStack {
                        if !vm.orderList.isEmpty {
                            if vm.noMoreData {
                                Text("没有更多数据了")
                            } else {
                                Button("点击加载更多") {
                                    Task {
                                        await vm.loadMore()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Divider()
        }
        .disabled(vm.isLoadingData)
        .showLoading($vm.isLoadingData)
        .adaptionOnChange(of: isPresented) { newValue in // 第一次加载之后不会再变化，可以认为是 viewDidLoad
            if newValue {
                Task {
                    await vm.loadData()
                }
            }
        }
        .refreshable {
            await vm.loadData()
        }
    }
    
}

struct ScrollRefreshTest02: View {
    
    @MainActor class ViewModel: ObservableObject {
        
        // MARK: - extern
        
        var orderId = -1 // 表示没有
        
        // MARK: - data
        
        @Published var isLoadingData = false
        
        @Published var orderInfo: String? = nil
        
        func loadData() async {
            isLoadingData = true
            let info: String? = await withCheckedContinuation { continuatino in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    continuatino.resume(returning: "加载的订单信息")
                }
            }
            orderInfo = info
            isLoadingData = false
        }
        
    }
    
    @StateObject var vm: ViewModel
    @Environment(\.isPresented) var isPresented
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            GeometryReader { geometry in
                ScrollView {
                    
                    if let info = vm.orderInfo {
                        
                        VStack {
                            Text(info)
                            Button("点击刷新") {
                                Task {
                                    await vm.loadData()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                    } else {
                        
                        Rectangle()
                            .fill(.clear)
                            .frame(height: geometry.size.height)
                            .frame(maxWidth: .infinity)
                            .overlay {
                                Text("没有数据时的情况")
                            }
                        
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color.init(uiColor: UIColor.systemGroupedBackground))
            }
            Divider()
        }
        .disabled(vm.isLoadingData)
        .overlay {
            if vm.isLoadingData {
                ProgressView()
            }
        }
        .adaptionOnChange(of: isPresented) { newValue in
            if newValue {
                Task {
                    await vm.loadData()
                }
            }
        }
        .refreshable {
            await vm.loadData()
        }
    }
    
}

#Preview {
    ScrollRefreshTest()
}

#Preview("list") {
    let vm = ScrollRefreshTest01.ViewModel()
    return ScrollRefreshTest01(vm: vm)
}

#Preview("detail") {
    ScrollRefreshTest02(vm: ScrollRefreshTest02.ViewModel())
}
