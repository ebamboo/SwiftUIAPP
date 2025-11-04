//
//  DragGestureView.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/26.
//

import SwiftUI

struct DragGestureView: View {
    
    @State var originOffset = CGSize.zero
    @State var gestureOffset = CGSize.zero
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.gray)
                .frame(width: 100, height: 100)
                .overlay {
                    Text("点击复位")
                }
                .offset(
                    x: originOffset.width + gestureOffset.width,
                    y: originOffset.height + gestureOffset.height
                )
                .onTapGesture {
                    originOffset = .zero
                }
                .gesture(
                    DragGesture()
                        .onChanged{ info in
                            gestureOffset = info.translation
                        }
                        .onEnded { info in
                            originOffset = .init(
                                width: originOffset.width + info.translation.width,
                                height: originOffset.height + info.translation.height
                            )
                            gestureOffset = .zero // 归零
                        }
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.cyan
        }
    }
    
}

#Preview {
    DragGestureView()
}
