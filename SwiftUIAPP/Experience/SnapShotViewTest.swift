//
//  SnapShotViewTest.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/27.
//

import SwiftUI

struct SnapShotViewTest: View {
    
    @State var text = "截图测试"
    
    @State var shotImage: UIImage?
    
    var myview: some View {
        
        VStack(spacing: 8) {
            Text(text)
                .frame(minHeight: 44)
                .lineLimit(nil)
                .background(.white)
            Image(.low02)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 160)
        }
        .frame(width: 300)
        .background(Color.cyan)
        .ignoresSafeArea()
        
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("修改分享的文字")
                    TextField("测试的文字", text: $text)
                        .foregroundStyle(.orange)
                }
                
                myview
                
                Button("截图") {
                    shotImage = myview.adaptionSnapshot()
                }
                
                Image(uiImage: shotImage ?? UIImage(systemName: "star")!)
                
            }
        }
    }
}

#Preview {
    SnapShotViewTest()
}
