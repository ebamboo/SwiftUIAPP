//
//  BridgeIndicatorView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/27.
//

import SwiftUI

extension View {
    
    public func showLoading(_ isLoading: Binding<Bool>) -> some View {
        overlay(
            BridgeIndicatorView(isLoading: isLoading)
                .frame(width: 100, height: 100)
        )
    }
    
}

struct BridgeIndicatorView: UIViewRepresentable {
    
    @Binding var isLoading: Bool
    
    func makeUIView(context: Context) -> UIView {
        let back = UIView()
        back.backgroundColor = .black.withAlphaComponent(0.65)
        back.layer.cornerRadius = 8
        back.clipsToBounds = true
        
        let loadingView = UIActivityIndicatorView()
        loadingView.style = .large
        loadingView.color = .white
        loadingView.startAnimating()
        
        back.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerXAnchor.constraint(equalTo: back.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: back.centerYAnchor).isActive = true
        
        return back
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        uiView.isHidden = !isLoading
    }
    
}
