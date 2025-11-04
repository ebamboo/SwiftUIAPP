//
//  PickerPageTest.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/27.
//

import SwiftUI

struct PickerPageTest: View {
    
    @State var showSinglePicker = false
    @State var selectedIndex: Int? = nil
    
    @State var showMultiPicker = false
    
    @State var optionList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    
    var body: some View {
        
        VStack {
            
            Button("单选") {
                showSinglePicker = true
            }
            .sheet(isPresented: $showSinglePicker, content: {
                SinglePicker(optionList: $optionList)
            })
            
            Button("多选") {
                showMultiPicker = true
            }
            .sheet(isPresented: $showMultiPicker, content: {
                MultiPicker(optionList: $optionList)
            })
            
            Text("联动选择或者特殊格式的时间选择使用BRPickerView桥接")
        }
        
    }
    
    struct SinglePicker: View {
        
        // 如果没有专门的确认按钮，只能通过数据绑定来回传选择的数据！！！！！1
        @State var title = "请选择"
        @Binding var optionList: [String]
        
        @State var selectedIndex: Int? = nil
        
        var body: some View {
            AdaptionNavigationStack {
                VStack(spacing: 0) {
                    Divider()
                    List {
                        ForEach(0..<optionList.count, id: \.self) { i in
                            HStack {
                                Text(optionList[i])
                                Spacer()
                                if selectedIndex == i {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                            .contentShape(.rect)
                            .onTapGesture {
                                selectedIndex = i
                            }
                        }
                    }
                    Divider()
                }
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
            }
            .adaptionPresentationDetents([.large, .medium])
        }
        
    }
    
    
    struct MultiPicker: View {
        
        // 如果没有专门的确认按钮，只能通过数据绑定来回传选择的数据！！！！！1
        @State var title = "请选择"
        @Binding var optionList: [String]
        
        @State var selectedIndexs: [Int] = []
        
        var body: some View {
            AdaptionNavigationStack {
                VStack(spacing: 0) {
                    Divider()
                    List {
                        ForEach(0..<optionList.count, id: \.self) { i in
                            HStack {
                                Text(optionList[i])
                                Spacer()
                                if selectedIndexs.contains(i) {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                            .contentShape(.rect)
                            .onTapGesture {
                                if selectedIndexs.contains(i) {
                                    selectedIndexs.remove(at: selectedIndexs.firstIndex(of: i)!)
                                } else {
                                    selectedIndexs.append(i)
                                }
                            }
                        }
                    }
                    Divider()
                }
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
            }
            .adaptionPresentationDetents([.large, .medium])
        }
        
    }
    
}

#Preview {
    PickerPageTest()
}
