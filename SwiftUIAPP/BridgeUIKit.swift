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

/// 支持设置自定义背景颜色
struct BridgeTextEditor: View {
    var body: some View {
        Text("fdfd")
    }
}
