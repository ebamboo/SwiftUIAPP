//
//  SimpleGestureView.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/26.
//

import SwiftUI

struct SimpleGestureView: View {
    
    @State var num1 = 1
    @State var num2 = 1
    
    @State var isPressing = false
    
    var body: some View {
        VStack {
            
            Text("可通过 highPriorityGesture，控制手势优先级")
            Spacer()
            
            Text("响应 tap 事件修改数字：\(num1)")
            Text("双击事件")
                .frame(width: 200, height: 100)
                .background(.gray)
                .onTapGesture(count: 2, perform: {
                    num1 = Int.random(in: 1...100)
                })
            Spacer()
            Text("响应 longPress 事件修改数字：\(num2)")
            
            Text("长按事件3s")
                .frame(width: 200, height: 100)
                .background(.gray)
                .onLongPressGesture(minimumDuration: 3, maximumDistance: 10) {
                    num2 = Int.random(in: 1...100)
                } onPressingChanged: { isPressing in
                    self.isPressing = isPressing
                }
            Text("是否正在按压：\(isPressing ? "是" : "否")")
            Text("显然，按压时间超过最小时间时，自动成功并结束该事件")
        }
        .frame(height: 500)
        .background(.cyan)
    }
}

#Preview {
    SimpleGestureView()
}
