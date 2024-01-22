//
//  MultiPickerView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI

struct MultiPickerView: View {
    
    let itemList = [
        ["开关按钮", "离散加减", "连续加减"],
        ["日期选择", "颜色选择", "图片选择"],
        ["单项选择"],
        ["模态单选", "模态多选"],
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("多功能选择")
            }.frame(height: 44)
            Divider()
            
            List(0..<itemList.count, id: \.self) { sectionIndex in
                Section {
                    ForEach(0..<itemList[sectionIndex].count, id: \.self) { rowIndex in
                        Text(itemList[sectionIndex][rowIndex])
                    }
                }
            }
            
            Divider()
        }
    }
    
}

#Preview {
    MultiPickerView()
}
