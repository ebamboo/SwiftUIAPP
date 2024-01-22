//
//  RootView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI

struct RootView: UIViewControllerRepresentable {
    
    @State var currentIndex = 0
    
    @ViewBuilder var contentView: some View {
        TabView {
            StudyView()
                .tabItem {
                    Label("学习", systemImage: "graduationcap")
                }
                .tag(0)
            ExperienceView()
                .tabItem {
                    Label("实践", systemImage: "star")
                }
                .tag(1)
        }
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationVC = UINavigationController(
            rootViewController: UIHostingController(rootView: contentView)
        )
        navigationVC.navigationBar.isHidden = true
        navigationVC.view.backgroundColor = .green
        return navigationVC
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
        
}

#Preview {
    RootView()
}
