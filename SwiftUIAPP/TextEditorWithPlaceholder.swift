//
//  TextEditorWithPlaceholder.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2026/7/7.
//

import SwiftUI

/// 自定义的带有 placeholder 的多行输入框，通过原生 SwiftUI 实现。
struct TextEditorWithPlaceholder: View {
    
    @Binding var text: String
    
    var font: Font = .body
    let placeholder: String
    var placeholderColor: Color = Color(.placeholderText)
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // TextEditor
            if #available(iOS 16.0, *) {
                TextEditor(text: $text)
                    .font(font)
                    .scrollContentBackground(.hidden) // iOS 16+ 隐藏默认背景
                    .background(Color.clear)
            } else {
                // Fallback on earlier versions
            }
            // Placeholder
            if text.isEmpty {
                Text(placeholder)
                    .font(font)
                    .foregroundColor(placeholderColor)
                    .padding(.horizontal, 5) // 校对位置
                    .padding(.vertical, 8)
                    .allowsHitTesting(false) // 允许点击穿透到 TextEditor
            }
        }
    }
    
}
