//
//  CombineGestureView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI

struct CombineGestureView: View {
    
    @State var dragable = false // 是否可以拖动，可拖动时放大视图
    
    @State var originOffset = CGSize.zero
    @State var gestureOffset = CGSize.zero
    
    var body: some View {
        VStack {
            
            let longPress = LongPressGesture(minimumDuration: 0.8)
                .onEnded { _ in
                    withAnimation {
                        dragable = true
                    }
                }
            let drag = DragGesture()
                .onChanged{ info in
                    gestureOffset = info.translation
                }
                .onEnded { info in
                    originOffset = .init(
                        width: originOffset.width + info.translation.width,
                        height: originOffset.height + info.translation.height
                    )
                    gestureOffset = .zero // 归零
                    withAnimation {
                        dragable = false
                    }
                }
            
            Text("目前只做初步了解")
            Text("使用 sequenced 组合一个手势队列")
            Text("以下做了一个简单例子，长按之后才可以拖动方块")
            Spacer()
            Rectangle()
                .fill(.gray)
                .frame(width: 100, height: 100)
                .overlay {
                    Text("点击复位")
                }
                .scaleEffect(dragable ? 1.5 : 1.0) // 可拖动期间放大
                .offset(
                    x: originOffset.width + gestureOffset.width,
                    y: originOffset.height + gestureOffset.height
                )
                .onTapGesture {
                    originOffset = .zero
                }
                .gesture(
                    longPress.sequenced(before: drag)
                )
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.cyan
        }
    }
    
}

#Preview {
    CombineGestureView()
}
