//
//  AccessWindowTest.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2026/7/2.
//

import SwiftUI

/// SwiftUI 中访问 UIWindow
/// 同样的思路，我们可以获取所在的 UIViewController、UINavigationController、UITableViewController 等等。
struct AccessWindowTest: View {
    
    @State var window: UIWindow? = nil
    
    var body: some View {
        VStack {
            
            Button("测试访问 uiwindow") {
                
                let label = UILabel()
                label.backgroundColor = .systemGroupedBackground
                label.numberOfLines = 0
                label.frame = .init(
                    x: 20,
                    y: 120,
                    width: 200,
                    height: 500
                )
                label.text = """
                在 window 上添加了一个测试的 UILabel。
                label.frame = .init(
                    x: \(label.frame.minX),
                    y: \(label.frame.minY),
                    width: \(label.frame.width),
                    height: \(label.frame.height)
                )
                """
                window?.addSubview(label)
                
            }
            
        }
        .background {
            WindowReader(window: $window)
        }
    }
}
struct WindowReader: UIViewRepresentable {
    
    @Binding var window: UIWindow?
    
    func makeUIView(context: Context) -> UIView {
        UIView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        Task { @MainActor in
            window = uiView.window
        }
    }
}

#Preview {
    AccessWindowTest()
}
