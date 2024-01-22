//
//  TextInputView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI

struct TextInputView: View {
    
    let itemList = ["单行输入", "单行密码输入", "多行输入"]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("文字输入")
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
    TextInputView()
}
