//
//  RotationGestureView.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/26.
//

import SwiftUI

struct RotationGestureView: View {
    
    @State var originAngle = Angle.zero
    @State var gestureAngle = Angle.zero
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.gray)
                .frame(width: 300, height: 44)
                .overlay {
                    Text("点击复位")
                }
                .rotationEffect(originAngle + gestureAngle)
                .onTapGesture {
                    originAngle = .zero
                }
                .gesture(
                    RotationGesture() // 注意 iOS 17 之后重命名为 RotateGesture
                        .onChanged { info in
                            gestureAngle = info
                        }
                        .onEnded { info in
                            originAngle += info
                            gestureAngle = .zero // 归零
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
    RotationGestureView()
}
