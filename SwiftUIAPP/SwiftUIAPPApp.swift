//
//  SwiftUIAPPApp.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/22.
//

import SwiftUI

@main
struct SwiftUIAPPApp: App {
    var body: some Scene {
        WindowGroup {
//            TestView()
            
            RootView()
                .ignoresSafeArea() // 占用全屏幕尺寸
            
        }
    }
}
