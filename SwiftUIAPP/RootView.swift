//
//  RootView.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/22.
//

import SwiftUI

struct RootView: UIViewControllerRepresentable {
    
    @State var currentIndex = 0
    
    // 使用 "导航控制器包裹着标签控制器" 这种方式，可以实现自动隐藏标签栏功能
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
        // 1、隐藏导航栏以自定义的方式完全控制导航栏
        // 2、使用该方式隐藏导航栏，具备原生的侧滑返回功能，不影响项目中其他模块的导航栏配置
        navigationVC.navigationBar.isHidden = true
        return navigationVC
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
        
}

#Preview {
    RootView().ignoresSafeArea() // 占用全屏幕尺寸
}
