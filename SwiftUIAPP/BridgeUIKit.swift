//
//  BridgeUIKit.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/24.
//

import SwiftUI
import SDWebImage

/// 支持 gif 等动图
struct BridgeImageView: UIViewRepresentable {
    
    // MARK: - public
    
    @State var url: URL
    @State var placeholderImage: UIImage?
    
    init(url: URL, placeholderImage: UIImage? = nil, configration: ((UIImageView) -> Void)? = nil)  {
        configration?(imageView)
        self._url = State(initialValue: url)
        self._placeholderImage = State(initialValue: placeholderImage)
    }

    // MARK: - life
    
    private let imageView = UIImageView()
    
    func makeUIView(context: Context) -> UIImageView {
        imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.sd_setImage(with: url, placeholderImage: placeholderImage)
    }
    
}

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
            textView = UITextView()
        }
        configration?(textView)
        self._text = text
    }
    
    // MARK: - life
    
    private let textView: UITextView
    
    func makeUIView(context: Context) -> UITextView {
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        textView.text = text
    }
    
    func makeCoordinator() -> TextViewDelegate {
        TextViewDelegate { text in
            self.text = text
        }
    }
    
    // MARK: - class
    
    class TextViewDelegate: NSObject, UITextViewDelegate {
        
        var onEditingChanged: (String) -> Void
        
        init(onEditingChanged: @escaping (String) -> Void) {
            self.onEditingChanged = onEditingChanged
        }
        
        func textViewDidChange(_ textView: UITextView) {
            onEditingChanged(textView.text ?? "")
        }
        
    }

    class AutoSizeTextView: UITextView {
        
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
    
}
