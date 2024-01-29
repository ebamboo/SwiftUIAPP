//
//  OrganizationView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI

struct OrganizationView: View {
    
    @State var showPage3 = false
    
    @State var showMulitModal = false
    @State var showNavigationModal = false
    
    @State var showAlert = false
    @State var showActionSheet = false
    @State var showModal = false
    @State var showFullModal = false
    
    var body: some View {
        VStack(spacing: 0) {
            Text("第二页")
                .frame(height: 44)
            Divider()
            List {
                
                Section {
                    
                    let text1 = """
                        说明：
                        1、tabview 和 navigation 核心功能是组织和导航，它们对应的 bar 只是一个方便功能，因此根据可实际情况隐藏自定义；
                        2、一般项目都会隐藏导航栏，自定义一个高度灵活、可控制的 bar；标签栏可视情况决定是否隐藏并自定义；
                        """
                    Text(text1)
                    
                    let text2 = """
                        有两种组织结构：
                        1、tabview 包裹着 navigation。
                        这种方式是自热的，然而在 SwiftUI 中我们不能优雅的隐藏标签栏。
                        2、navigation 包裹着 tabview。
                        这种方式本质是用 tabview 作为 navigation 的 root，导航至下一页时，自热而然的就会把 tabview 整体覆盖遮挡---也即隐藏了标签栏。
                        """
                    Text(text2)
                    
                }
                
                Section {
                    
//                    NavigationLink(
//                        destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
//                        tag: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/,
//                        selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/,
//                        label: {/*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/})
                    
                    ZStack {
                        NavigationLink(isActive: $showPage3) {
                            NavigationPageTest01(showSelf: $showPage3)
                        } label: {
                            Text("------")
                        }
                        
                        .hidden()
                        Button("导航至下一页") {
                            showPage3 = true
                        }
                    }
                    .environment(\.showNavigationPage3, $showPage3)
                    
                } footer: {
                    let text = """
                        pop 至指定页面。
                        这个需求无论在 UIKit 中还是 SwiftUI 中，都要思考如何清晰明确的描述要 pop 至的页面。
                        需要说明的是，这不是一个常用功能，虽然它可能是必需的。
                        在 UIKit 中我们并没有无歧义的做这件事情，只是简单计算 Index 或者 判断一下类型，这可以工作，但可能会出问题；
                        在 SwiftUI 中，我们可以借助环境变量，把需要导航的页面的控制显示与否的数据放入环境中，在需要的地方修改这个数据既可以达到 pop 指定页面功能。
                        很显然，如果大量使用该功能（实际上这个需求并不是很多）会导致很多环境变量处理该问题；
                        当然我们也可以把具体的页面显示与否控制数据传送给所有可能用到的地方！！！
                        """
                    Text(text)
                }
                
                Section {
                    Text("模态弹出多个页面")
                        .onTapGesture {
                            showMulitModal = true
                        }
                        .sheet(isPresented: $showMulitModal, content: {
                            ModalTestView01()
                        })
                        .environment(\.showMultiModalView, $showMulitModal)
                    Text("模态弹出导航栏")
                        .onTapGesture {
                            showNavigationModal = true
                        }
                        .sheet(isPresented: $showNavigationModal, content: {
                            ModalNavigtionTest()
                        })
                        .environment(\.showNavigationModalView, $showNavigationModal)
                } header: {
                    Text("测试 dismiss 行为")
                } footer: {
                    let text = """
                        有导航栏是pop行为；有模态是dismiss行为；
                        在导航栏的root中执行 dismiss() 表示整个模块的dismiss行为；
                        """
                    Text(text)
                }
                
                Section {
                    
                    //---------
                    HStack {
                        Text("alert")
                        Spacer()
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        showAlert = true
                    }
                    .alert("这个是alert", isPresented: $showAlert) {
                        Button("cancel") {
                            
                        }
                        Button("ok") {
                            
                        }
                    } message: {
                        Text("可选的具体的message信息")
                    }
                    
                    //---------
                    HStack {
                        Text("action sheet")
                        Spacer()
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        showActionSheet = true
                    }
                    .confirmationDialog("title：这是个 action sheet", isPresented: $showActionSheet, titleVisibility: .visible) {
                        Button("1") {
                            
                        }
                        Button("2") {
                            
                        }
                    } message: {
                        Text("message： 使用新的 api 了")
                    }
                    
                    //---------
                    HStack {
                        Text("modal sheet")
                        Spacer()
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        showModal = true
                    }
                    .sheet(isPresented: $showModal, content: {
                        VStack(content: {
                            Text("Modal")
                        })
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.gray)
                        .adaptionPresentationDetents([.medium, .large]) // 注意使用的区域
                    })
                    
                    //---------
                    HStack {
                        Text("full modal sheet")
                        Spacer()
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        // 关闭展示动画
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            showFullModal = true
                        }
                    }
                    .fullScreenCover(isPresented: $showFullModal, content: {
                        TestFullDetail()
                    })
                }
                
            }
            Divider()
        }
    }
    
    struct TestFullDetail: View {
        
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            Button("通过 dismiss 环境变量关闭视图") {
                // 关闭 dismiss 动画
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    dismiss()
                }
            }
        }
        
    }
    
}

// MARK: - ===========

struct MultiModalViewKey: EnvironmentKey {
    
    typealias Value = Binding<Bool>
    
    static var defaultValue: Binding<Bool> = .constant(false)
    
}

extension EnvironmentValues {
    
    var showMultiModalView: Binding<Bool> {
        get {
            self[MultiModalViewKey.self]
        }
        set {
            self[MultiModalViewKey.self] = newValue
        }
    }
}

// MARK: - ===========

struct NavigationModalViewKey: EnvironmentKey {
    
    typealias Value = Binding<Bool>
    
    static var defaultValue: Binding<Bool> = .constant(false)
    
}

extension EnvironmentValues {
    
    var showNavigationModalView: Binding<Bool> {
        get {
            self[NavigationModalViewKey.self]
        }
        set {
            self[NavigationModalViewKey.self] = newValue
        }
    }
}

// MARK: - ===========

struct ModalTestView01: View {
    
    @State private var showModalView = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            Text("这是第一个模态视图")
                .font(.largeTitle)
            Button("点击弹窗第二个模态视图") {
                showModalView = true
            }
            .sheet(isPresented: $showModalView, content: {
                ModalTestView02()
            })
            Button("点击关闭当前模态") {
                dismiss()
            }
        }
    }
    
}

struct ModalTestView02: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.showMultiModalView) var showModuleModal
    
    var body: some View {
        VStack(spacing: 30) {
            Text("这是第二个模态视图")
                .font(.largeTitle)
            
            Button("点击关闭当前模态") {
                dismiss()
            }
            
            Button("关闭所有模态") {
                showModuleModal.wrappedValue = false
            }
        }
    }
    
}

// MARK: - ===========

struct ModalNavigtionTest: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        AdaptionNavigationStack {
            VStack(spacing: 30) {
                Text("带导航栏的模态视图的首页")
                    .font(.largeTitle)
                
                NavigationLink("导航至下一页") {
                    ModalNavigtionTestDetailView()
                }
                
                Button("关闭当前页面") {
                    dismiss()
                }
                
            }
        }
    }
    
}

struct ModalNavigtionTestDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.showNavigationModalView) var showNavagion
    
    var body: some View {
        VStack(spacing: 30) {
            Text("带导航栏的模态视图的下一页")
                .font(.largeTitle)
            
            Button("关闭当前页面") {
                dismiss()
            }
            
            Button("关闭所有页面") {
                showNavagion.wrappedValue = false
            }
            
        }
    }
    
}

// MARK: - ===========

struct NavigationPage03Key: EnvironmentKey {
    typealias Value = Binding<Bool>
    
    static var defaultValue: Binding<Bool> = .constant(false)
    
    
}

extension EnvironmentValues {
    
    var showNavigationPage3: Binding<Bool> {
        get {
            self[NavigationPage03Key.self]
        }
        set {
            self[NavigationPage03Key.self] = newValue
        }
    }
}

struct NavigationPageTest01: View {
    
    @Binding var showSelf: Bool
    
    var body: some View {
        VStack {
            Text("第三页")
            Divider()
            Spacer()
            NavigationLink("导航至下一页") {
                NavigationPageTest02(showBefor: $showSelf)
            }
            Button("返回") {
                showSelf = false
            }
            Spacer()
            Divider()
        }
    }
    
}

struct NavigationPageTest02: View {
    
    @Binding var showBefor: Bool
    
    @Environment(\.showNavigationPage3) var showNavigationPage3
    
    var body: some View {
        VStack {
            Text("第四页")
            Divider()
            Spacer()
            Button("返回至第二页") {
                showNavigationPage3.wrappedValue = false
//                showBefor = false
            }
            Spacer()
            Divider()
        }
    }
    
}

// MARK: - ===========

#Preview {
    OrganizationView()
}
