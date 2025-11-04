//
//  SnapShotViewTest.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/27.
//

import SwiftUI

struct SnapShotViewTest: View {
    
    @State var text = "截图测试"
    
    @State var shotImage: UIImage?
    
    var myview = MyView()
    
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
                    print("outer ===\(myview.size)")
                    shotImage = myview.getShotImage()
                }
                
                Image(uiImage: shotImage ?? UIImage(systemName: "star")!)
                
            }
        }
    }
    
    struct MyView: View {
        
        // MARK: - extern
        
//        @Binding var text: String
        
        let text = "挡杀佛是否水岸东11111方1111111111是是发发发的方式防守打法阿是放松放松防守打法士大夫士大夫撒发生 "
        
        
        func getShotImage() -> UIImage {
            adaptionSnapshot(with: size)
        }
        
        // MARK: - life
        
        @State var size: CGSize = .init(width: 300, height: 233)
        
        var body: some View {
            
            VStack(spacing: 8) {
                
                Text(text)
                    .lineLimit(nil)
                    .background(.white)
                
                Image(.low02)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 160)
                    .clipped()
                
            }
            
            .frame(width: 300)
            .background {
                GeometryReader { geo in
                    let _ = {
                        size = geo.frame(in: .local).size
                    }()
//                    Color.clear
//                        .task(id: size) {
//                            
//                            
//                            DispatchQueue.main.async {
//                                
//                                self.size = size
//                                
//                                print("=== \(size)")
//                                print("+++ \(self.size)")
//                            }
//                        }
                }
            }
            
            .background(.cyan)
            .ignoresSafeArea()
        }
    }
    
    
    
}

#Preview {
    SnapShotViewTest()
}
