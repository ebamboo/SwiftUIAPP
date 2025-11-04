//
//  AlignmentView.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/25.
//

import SwiftUI

struct AlignmentView: View {
    var body: some View {
        VStack {
            
            VStack(alignment: .leading, spacing: 8) { // item alignment
                
                
                
                Text("容器的 item alignment 是内部 item之间的对齐方式")
                    .frame(width: 240)
                    .background(.gray)
                
                Text("容器的 frame alignment 是实际内容相对占用的空间的对齐方式")
                    .frame(width: 300)
                    .background(.gray)
                
                Text("这是个 frame trading 对齐；item leading 对齐")
                    .frame(width: 200, height: 80)
                    .background(.gray)
                
                Rectangle()
                    .fill(.gray)
                    .frame(width: 180, height: 80)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing) // frame alignment
            .background(.orange)
            
            VStack(alignment: .center) {
                
                Text("=============")
                    .frame(width: 200, height: 60)
                    .background(Color.orange)
                
                Text("=============")
                    .frame(width: 200, height: 60)
                    .background(Color.orange)
                
                ///
                /// alignmentGuide 第一个参数必须是容器的对齐方式一样，否则忽略无效；第二个参数是一个闭包，闭包中有个参数，根据该参数提供的信息调整对齐偏移量
                Text("100")
                    .frame(width: 100, height: 60)
                    .background(Color.orange)
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { dimension in
                        return dimension[HorizontalAlignment.center] - dimension.width / 2
                    })
                
                HStack(spacing: 0) {
                    Rectangle().fill(.orange)
                    Rectangle().fill(.yellow)
                    Rectangle().fill(.gray)
                    Rectangle().fill(.black)
                    Rectangle().fill(.blue)
                }
                .frame(width: 300, height: 60)
                .background(Color.orange)
                
                Text("100")
                    .frame(width: 100, height: 60)
                    .background(Color.orange)
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { dimension in
                        return dimension[HorizontalAlignment.center] + dimension.width / 2
                    })
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(.cyan)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}

#Preview {
    AlignmentView()
}
