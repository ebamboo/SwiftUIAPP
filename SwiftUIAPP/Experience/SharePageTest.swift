//
//  SharePageTest.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/27.
//

import SwiftUI

/*
 ！！！ 数据变化时会生成新的视图实例！！！
 */
struct SharePageTest: View {
    
    @State var shareText = "分享的原本文字"
    
    @State var showShareView = false
    
    var body: some View {
        VStack {
            
            Text(shareText)
            Button("试试修改分享的文字是否有效") {
                shareText = "文字修改了"
            }
            
            Spacer()
            
            AdaptionShareLink(items: [.text(shareText)]) {
                Text("封装的Link自动分享")
                    .foregroundStyle(.blue)
            } completion: { _, _, _, _ in
                
            }
            
            Spacer()
            
            Button("自己通过数据控制是否分享") {
                showShareView = true
            }
            .sheet(isPresented: $showShareView, content: {
                AdaptionShareView(items: [.text(shareText)])
            })

            
        }
        .padding()
        .frame(height: 400)
        .background(.gray)
    }
}

#Preview {
    SharePageTest()
}
