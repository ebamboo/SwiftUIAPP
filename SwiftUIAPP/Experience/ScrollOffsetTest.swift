//
//  ScrollOffsetTest.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI

struct ScrollOffsetTest: View {
    
    var body: some View {
        List {
            NavigationLink(destination: ScrollOffsetTest01()) {
                Text("使用 geometry")
            }
            NavigationLink(destination: ScrollOffsetTest02()) {
                Text("使用 anchor")
            }
            NavigationLink(destination: ScrollOffsetTest03()) {
                Text("常见使用场景")
            }
        }
    }
}

struct ScrollOffsetTest01: View {
    
    @State var position: CGPoint = .zero // top leading 位置
    
    var body: some View {
        VStack(spacing: 0) {
            Text("固定头部：偏移量 x\(position.x)  y\(position.y)")
                .frame(height: 44)
            Divider()
            ScrollView {
                VStack {
                    ForEach(0...26, id: \.self) { i in
                        Text("=====\(i)")
                            .frame(height: 44)
                            .frame(maxWidth: .infinity)
                            .background(.gray)
                    }
                }
                .background {
                    GeometryReader { geo in
                        Color.clear
                            .preference(
                                key: OffsetKey.self,
                                value: geo.frame(in: .named("Scroll")).origin
                            )
                    }
                }
                .onPreferenceChange(OffsetKey.self, perform: { value in
                    position = value
                })
            }
            .coordinateSpace(name: "Scroll")
            Divider()
        }
    }
    
    struct OffsetKey: PreferenceKey {
        static var defaultValue: CGPoint { CGPoint.zero }
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
    }
    
}

struct ScrollOffsetTest02: View {
    
    @State var position: CGPoint = .zero // top leading 位置
    
    var body: some View {
        VStack(spacing: 0) {
            Text("固定头部：偏移量 x\(position.x)  y\(position.y)")
                .frame(height: 44)
            Divider()
            ScrollView {
                VStack {
                    ForEach(0...26, id: \.self) { i in
                        Text("=====\(i)")
                            .frame(height: 44)
                            .frame(maxWidth: .infinity)
                            .background(.gray)
                    }
                }
                .anchorPreference(key: OffsetKey.self, value: .topLeading, transform: { anchor in
                    [anchor]
                })
            }
            .backgroundPreferenceValue(OffsetKey.self) { value in // 直接在背景上添加监听事件
                GeometryReader(content: { geometry in
                    if let anchor = value.first {
                        let _ = {
                            DispatchQueue.main.async { // 注意在主线程更改数据
                                position = geometry[anchor]
                            }
                        }()
                    }
                })
            }
            Divider()
        }
    }
    
    struct OffsetKey: PreferenceKey {
        static var defaultValue: [Anchor<CGPoint>] { [] }
        static func reduce(value: inout [Anchor<CGPoint>], nextValue: () -> [Anchor<CGPoint>]) {}
    }
    
}

struct ScrollOffsetTest03: View {
    
    @State var position: CGPoint = .zero // top leading 位置
    
    var body: some View {
        
        VStack(spacing: 0) {
            Text("悬浮特定视图")
                .frame(height: 44)
            Divider()
            ZStack(alignment: .top) {
                ScrollView {
                    VStack {
                        ForEach(0...26, id: \.self) { i in
                            Text("=====\(i)")
                                .frame(height: 44)
                                .frame(maxWidth: .infinity)
                                .background(.gray)
                        }
                    }
                    .anchorPreference(key: OffsetKey.self, value: .topLeading, transform: { anchor in
                        [anchor]
                    })
                }
                .backgroundPreferenceValue(OffsetKey.self) { value in // 直接在背景上添加监听事件
                    GeometryReader(content: { geometry in
                        if let anchor = value.first {
                            let _ = {
                                DispatchQueue.main.async { // 注意在主线程更改数据
                                    position = geometry[anchor]
                                }
                            }()
                        }
                    })
                }
                if position.y < -100 {
                    Rectangle()
                        .fill(.white.opacity(0.8))
                        .frame(height: 60)
                        .overlay {
                            Text("可根据某个视图的偏移量控制显示/隐藏悬浮视图")
                        }
                }
                    
            }
            Divider()
        }
    }
    
    struct OffsetKey: PreferenceKey {
        static var defaultValue: [Anchor<CGPoint>] { [] }
        static func reduce(value: inout [Anchor<CGPoint>], nextValue: () -> [Anchor<CGPoint>]) {}
    }
    
}

#Preview {
    ScrollOffsetTest()
}

#Preview("geometry") {
    ScrollOffsetTest01()
}

#Preview("anchor") {
    ScrollOffsetTest02()
}

#Preview("use") {
    ScrollOffsetTest03()
}
