//
//  BridgeTextEditor.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/24.
//

import SwiftUI

/// 支持更多属性配置
/// 支持 focused 功能
/// 会尽可能地占用更多可用空间
///
/// 注意：根据 autoSize 不同情况设置不同的布局；
/// true：不可以设置 height 或者 maxHeight，否则可能会超出视图显示范围；可以设置 minHeight；
/// false：设置 height 或者 minHeight 为实际高度；设置 maxHeigh 无效；
struct BridgeTextEditor: UIViewRepresentable {
    
    // MARK: - public
    
    @Binding var text: String
    
    init(text: Binding<String>, autoSize: Bool = true, configration: ((UITextView) -> Void)? = nil) {
        if autoSize {
            textView = AutoSizeTextView()
        } else {
            textView = DefaultTextView()
        }
        textView.addKeyboardToolBarDoneItem()
        configration?(textView)
        self._text = text
    }
    
    // MARK: - life
    
    private let textView: ToolTextView
    
    func makeUIView(context: Context) -> UITextView {
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        textView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator { text in
            self.text = text
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var onEditingChanged: (String) -> Void
        
        init(onEditingChanged: @escaping (String) -> Void) {
            self.onEditingChanged = onEditingChanged
        }
        
        func textViewDidChange(_ textView: UITextView) {
            onEditingChanged(textView.text ?? "")
        }
        
    }
    
}

extension BridgeTextEditor {
    
    class ToolTextView: UITextView {
        
        func addKeyboardToolBarDoneItem() {
            let done = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(self.closeKeyboard))
            let keyboardToolBar = UIToolbar(frame: .init(x: 0, y: 0, width: 1, height: 100))
            keyboardToolBar.items = [UIBarButtonItem.flexibleSpace(), done]
            keyboardToolBar.sizeToFit()
            inputAccessoryView = keyboardToolBar
        }
        
        @objc func closeKeyboard() {
            resignFirstResponder()
        }
        
    }
    
    class AutoSizeTextView: ToolTextView { // 自适应高度
        
        override var contentSize: CGSize {
            didSet {
                invalidateIntrinsicContentSize()
            }
        }
        
        override var intrinsicContentSize: CGSize {
            layoutIfNeeded()
            return contentSize
        }
        
    }
    
    class DefaultTextView: ToolTextView { // 原生功能
        
    }
    
}

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
