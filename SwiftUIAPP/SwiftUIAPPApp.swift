//
//  SwiftUIAPPApp.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI

@main
struct SwiftUIAPPApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .ignoresSafeArea() // 占用全屏幕尺寸
        }
    }
}
