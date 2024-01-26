//
//  MagnificationGestureView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI

struct MagnificationGestureView: View {
    
    @State var originScale = 1.0
    @State var gestureScale = 1.0
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.gray)
                .frame(width: 160, height: 44)
                .overlay {
                    Text("点击复位")
                }
                .scaleEffect(originScale * gestureScale)
                .onTapGesture {
                    originScale = 1
                }
                .gesture(
                    MagnificationGesture() // 注意 iOS 17 之后重命名为 MagnifyGesture
                        .onChanged { info in // 每次变化都是在上次变化基础上
                            gestureScale = info
                        }
                        .onEnded { info in
                            originScale *= info
                            gestureScale = 1.0 // 归零
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
    MagnificationGestureView()
}
