//
//  StudyView.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/22.
//

import SwiftUI

struct StudyView: View {
    
    let infoList: [(title: String, itemList: [String])] = [
        (title: "基础组件", itemList: [
            "基本显示组件", "文字输入", "多功能选择"
        ]),
        (title: "基础布局", itemList: [
            "padding\nSpacer", "item alignment\nframe alignment\nalignmentGuide", "geometry"
        ]),
        (title: "组织和跳转", itemList: [
            "组织和跳转"
        ]),
        (title: "ScrollView", itemList: [
            "LazyHStack/LazyVStack", "LazyHGrid/LazyVGrid", "List", "Form"
        ]),
        (title: "手势", itemList: [
            "点击和长按", "拖拽", "旋转", "缩放", "组合手势"
        ])
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
            
        case (1, 0):
            PaddingView()
        case (1, 1):
            AlignmentView()
        case (1, 2):
            GeometryView()
            
        case (2, _):
            OrganizationView()
            
        case (3, 0):
            LazyStackView()
        case (3, 1):
            LazyGridView()
        case (3, 2):
            Text("苹果风格的列表，高度封装，很难甚至不能配置；一般使用 LazyStack 代替；只在一些简单 Modal 页面或者设置页面使用")
        case (3, 3):
            Text("苹果风格的列表，高度封装，很难甚至不能配置；一般使用 LazyStack 代替；只在一些简单 Modal 页面或者设置页面使用")
            
        case (4, 0):
            SimpleGestureView()
        case (4, 1):
            DragGestureView()
        case (4, 2):
            RotationGestureView()
        case (4, 3):
            MagnificationGestureView()
        case (4, 4):
            CombineGestureView()
            
        default:
            EmptyView()
            
        }
        
    }
    
}

#Preview {
    StudyView()
}
