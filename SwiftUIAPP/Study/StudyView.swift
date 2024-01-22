//
//  StudyView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI

struct StudyView: View {
    
    let infoList: [(title: String, itemList: [String])] = [
        (title: "基础组件", itemList: [
            "基本显示", "文字输入", "多功能选择"
        ]),
        (title: "基础布局", itemList: [
            "文字", "图片", "Label", "按钮", "形状", "单行输入", "单行密码输入", ""
        ]),
        (title: "组织和跳转", itemList: [
            "文字", "图片", "Label", "按钮", "形状", "单行输入", "单行密码输入", ""
        ]),
        (title: "ScrollView", itemList: [
            "文字", "图片", "Label", "按钮", "形状", "单行输入", "单行密码输入", ""
        ]),
        (title: "手势", itemList: [
            "文字", "图片", "Label", "按钮", "形状", "单行输入", "单行密码输入", ""
        ]),
        (title: "动画", itemList: [
            "文字", "图片", "Label", "按钮", "形状", "单行输入", "单行密码输入", ""
        ]),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("学习")
            }.frame(height: 44)
            Divider()
            List {
                ForEach(0..<infoList.count, id: \.self) { sectionIndex in
                    Section {
                        ForEach(0..<infoList[sectionIndex].itemList.count, id: \.self) { rowIndex in
                            NavigationLink(infoList[sectionIndex].itemList[rowIndex]) {
                                destinationView(section: sectionIndex, row: rowIndex)
                            }
                        }
                    } header: {
                        Text(infoList[sectionIndex].title)
                    }
                }
            }
        }
    }
    
    @ViewBuilder func destinationView(section: Int, row: Int) -> some View {
        switch (section, row) {
        case (0, 0):
            BasicShowView()
        case (0, 1):
            TextInputView()
        case (0, 2):
            MultiPickerView()
        default:
            EmptyView()
        }
    }
    
}

#Preview {
    StudyView()
}
