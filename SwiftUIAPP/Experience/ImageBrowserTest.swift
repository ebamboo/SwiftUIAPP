//
//  ImageBrowserTest.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI

struct ImageBrowserTest: View {
    
    @State var showBroswer = false
    
    let imageList = ["height_01", "height_02", "height_03", "height_04"]
    
    
    
    
    var body: some View {
        ZStack {
            
            VStack {
                Button("点击浏览图片") {
                    showBroswer = true
                }
                Rectangle()
                    .fill(.cyan)
                    .frame(width: 100, height: 100)
                Spacer()
                Rectangle()
                    .fill(.cyan)
                    .frame(width: 100, height: 100)
            }
            
            if showBroswer {
                TabView {
                    ForEach(0..<imageList.count, id: \.self) { index in
                        BrowserPage(name: imageList[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .background {
                    Color.black.opacity(0.3).ignoresSafeArea()
                }
                .onTapGesture {
                    showBroswer = false
                }
            }
            
        }
    }
    
    struct BrowserPage: View {
        
         var name: String
        
        @State var originScale = 1.0
        @State var gestureScale = 1.0
        
        var body: some View {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(originScale * gestureScale)
//                .gesture(
//                    MagnificationGesture()
//                        .onChanged({ info in
//                            gestureScale = info
//                        })
//                        .onEnded({ info in
//                            originScale *= info
//                            gestureScale = 1
//                        })
//                )
        }
        
    }
    
    
}

#Preview {
    ImageBrowserTest()
}
