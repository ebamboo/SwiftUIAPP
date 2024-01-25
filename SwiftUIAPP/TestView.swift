//
//  TestView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/24.
//

import SwiftUI


struct TestView: View {
    
    let url1 = URL(string: "https://gitee.com/ebamboo/Assets/raw/master/BBPictureBrowser/jpeg/03.jpeg")!

    let url2 = URL(string: "https://gitee.com/ebamboo/Assets/raw/master/BBPictureBrowser/gif/02.gif")!

    let url3 = URL(string: "https://gitee.com/ebamboo/Assets/raw/master/BBPictureBrowser/gif/04.gif")!

    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            ScrollView {
            
                AsyncImage(url: url1)
                
                AsyncImage(url: url1)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                    .clipped()
            
            }
            Divider()
        }
    }
    
}

#Preview {
    TestView()
}
