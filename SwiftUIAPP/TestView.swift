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

    @State var text = "文艺复兴"
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            ScrollView {
            
                
                Button("修改modal文字试试") {
                    text += "中国"
                }
                Text(text)
                
                MyTestPicker(testText: text) {
                    Text("click select")
                        .foregroundStyle(.blue)
                }
            
            }
            Divider()
        }
    }
    
}


struct MyTestPicker<Content: View>: View {
    
    @State var testText = "origin"
    
    @ViewBuilder var content: () -> Content
    
    @State var showPicker = false
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        content()
            .onTapGesture {
                
            }
    }
}


struct PickerPage: View {
    
    let text: String
    
    var body: some View {
        Text(text)
    }
    
}

#Preview {
    TestView()
}
