//
//  PaddingView.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/25.
//

import SwiftUI

struct PaddingView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("使用了 padding")
                .padding()
                .background(.gray)
            
            Text("没使用 padding")
                .background(.gray)
            
            Text("使用了 padding")
                .background(.gray)
                .padding()
                .background(.orange)
            
            HStack {
                Text("使用 Spacer")
                Spacer()
                Text("使用 Spacer")
            }
            .background(.gray)
            
            HStack {
                Text("使用 Spacer")
                Spacer()
                Text("使用 Spacer")
                Spacer()
                Text("使用 Spacer")
            }
            .background(.gray)
            
            HStack {
                Text("使用 Spacer")
                Spacer()
                Text("使用 Spacer")
                Spacer().frame(width: 10)
                Text("使用 Spacer")
            }
            .background(.gray)
            
            let text1 = """
               使用 Offset 也可以使内容偏移，但是 Offset 只是更改了内容，并没有改变原有的布局；
               另一方面，可以认为 Offset 在视图布局加载渲之后，再调整视图内容位置；
               一般和拖动手势结合使用；尽量减少使用；
               """
            Text(text1)
                .background(.gray)
            
            let text2 = """
               1、使用了 Offset；
               2、注意看布局没有变化，内容位置变了；
               """
            Text(text2)
                .frame(width: 180, height: 150)
                .background(.gray)
                .offset(x: 200)
                .border(.red, width: 2)
            
        }
        .background(.cyan)
    }
}

#Preview {
    PaddingView()
}
