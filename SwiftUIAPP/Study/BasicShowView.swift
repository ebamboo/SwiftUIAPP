//
//  BasicShowView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI

struct BasicShowView: View {
    
    let itemList = ["文字", "图片", "Label", "按钮", "形状"]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("基本显示")
            }.frame(height: 44)
            Divider()
            List(itemList, id: \.self) { item in
                Text(item)
            }
            Divider()
        }
    }
    
}

#Preview {
    BasicShowView()
}
