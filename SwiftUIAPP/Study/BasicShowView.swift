//
//  BasicShowView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI

private let url1 = URL(string: "https://gitee.com/ebamboo/Assets/raw/master/BBPictureBrowser/jpeg/05.jpeg")!
private let url2 = URL(string: "https://gitee.com/ebamboo/Assets/raw/master/BBPictureBrowser/jpeg/03.jpeg")!
private let url3 = URL(string: "https://gitee.com/ebamboo/Assets/raw/master/BBPictureBrowser/gif/04.gif")!

struct BasicShowView: View {
    
    var textView: some View {
        Section {
            Text("简单设置")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .background { Color.gray }
            
            Text("背景前景设置;\n前景是过渡渐变色;背景是图片;")
                .font(Font.system(size: 28))
                .multilineTextAlignment(.leading) // 多行文字对齐
                .foregroundStyle( // 线性渐变色
                    .linearGradient(
                        colors: [.red, .blue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .background { // 背景图片
                    Image(.height03)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .clipped()
            
            Text("背景设置为渐变色")
                .font(Font.system(size: 28))
                .multilineTextAlignment(.trailing) // 多行文字对齐
                .background { // 线性渐变色
                    LinearGradient.linearGradient(
                        colors: [.red, .blue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
            
            Text("设置边框")
                .padding()
                .background(.gray)
                .border(.orange, width: 8)
            
            Text("设置圆角或其他形状")
                .multilineTextAlignment(.center)
                .frame(width: 120, height: 120)
                .background(.gray)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
            Text("同时设置边框和圆角，必须使用 overlay")
                .padding()
                .frame(height: 80)
//                .background(.gray) // 设置背景会影响一点点效果，所以把 Text 放在合适的背景上来满足需求；
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.orange, lineWidth: 2)
                }
            
            Group {
                Text("多属性文本设置")
                    .font(.system(size: 24))
                    .foregroundColor(.red)
                + Text("只需要多个 Text 相加。")
                    .font(.system(size: 28))
                    .foregroundColor(.blue)
                + Text("注意：设置属性时，保证返回的视图为Text。")
                    .font(.system(size: 20))
            }
            .multilineTextAlignment(.trailing)
            .background {
                Color.gray
            }
            
        } header: {
            HStack {
                Text("文字")
                    .font(.largeTitle)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(.white)
        }
    }
    
    var imageView: some View {
        Section {
            
            Image(.height01)
                .resizable() // 设置可伸缩
                .aspectRatio(contentMode: .fit) // 不设置高度 fit/fill 效果一样
                .frame(width: 240)
                .background(Color.gray)
            
            Image(.height01)
                .resizable() // 设置可伸缩
                .aspectRatio(contentMode: .fill) // 不设置高度 fit/fill 效果一样
                .frame(width: 240)
                .background(Color.gray)
            
            Image(.height01)
                .resizable() // 设置可伸缩
                .aspectRatio(contentMode: .fit) // 设置宽高观察 fit/fill 效果
                .frame(width: 240, height: 120)
                .background(Color.gray)
            
            Image(.height01)
                .resizable() // 设置可伸缩
                .aspectRatio(contentMode: .fill) // 设置宽高观察 fit/fill 效果
                .frame(width: 240, height: 120)
                .background(Color.gray)
                .clipped() // 设置宽高后，fill 方式可能超出视图本身，所以最好设置裁剪
            
            Image(.low02)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 180, height: 180)
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .stroke(Color.gray, lineWidth: 6)
                }
        } header: {
            HStack {
                Text("图片")
                    .font(.largeTitle)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(.white)
        }
    }
    
    var webImageView: some View {
        Section {
            
            Text("原生网络图片组件不支持gif动图")
            Text("结合SDWebImage桥接UIImageView至SwiftUI")
            
            AsyncImage(url: url1) // 直接设置
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
                .clipped()
           
            AsyncImage(url: url3) { image in // 提供 Placeholder 图片
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
            } placeholder: {
                Image(.height04)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
            }
            
            AsyncImage(url: url2) { phase in // 可以处理各种状态下的展示情况
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                } else if phase.error != nil {
                    Text("错误提示：\(phase.error?.localizedDescription ?? "")")
                } else {
                    ProgressView()
                }
            }
            
            
        } header: {
            HStack {
                Text("网络图片")
                    .font(.largeTitle)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(.white)
        }
    }
    
    var labelView: some View {
        Section {
            Label("基本用作标签", systemImage: "star")
            Label("用途较少", systemImage: "doc")
            Label(
                title: { Text("本质是文字和图片组合") },
                icon: { /*@START_MENU_TOKEN@*/Image(systemName: "42.circle")/*@END_MENU_TOKEN@*/ }
            )
            
            Label(
                title: {},
                icon: {
                    VStack {
                        Text("自定义Icon")
                        Image(.low01)
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: 44)
                    }
                }
            )
            .background(.gray)
            
        } header: {
            HStack {
                Text("Label")
                    .font(.largeTitle)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(.white)
        }
    }
    
    var buttonView: some View {
        Section {
            
            Button("简单按钮") {
                print("文字按钮")
            }
            
            Button {
                print("任意视图")
            } label: {
                VStack {
                    Text("可以是任意View组合")
                        .foregroundStyle(.red)
                    Image(.height03)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipped()
                }
            }
            .background(.gray)
            
        } header: {
            HStack {
                Text("按钮")
                    .font(.largeTitle)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(.white)
        }
    }
    
    var shapeView: some View {
        Section {
            
            Text("1、形状使用 fill 填充或者使用 stroke 画边")
            Text("2、形状会尽可能占用更多可用空间")
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 200, height: 128)
                .overlay {
                    Text("矩形")
                }
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 200, height: 128)
                .overlay {
                    Text("圆角矩形")
                }
            
            Circle()
                .fill(Color.white)
                .frame(width: 100, height: 100)
                .overlay {
                    Text("圆")
                }
            
            Ellipse()
                .fill(Color.white)
                .frame(width: 200, height: 100)
                .overlay {
                    Text("椭圆")
                }
            
            Capsule()
                .fill(Color.white)
                .frame(width: 100, height: 200)
                .overlay {
                    Text("胶囊状")
                }
            
            Text("可以使用 Path 实现很多形状")
            Text("目前只初步了解一下")
            Text("注意封口")
            
           Rectangle()
                .fill(.white)
                .frame(width: 320, height: 450)
                .overlay {
                    VStack(spacing: 0) {
                        
                        Path() { path in
                            path.move(to: CGPoint(x: 20, y: 20))
                            path.addLine(to: CGPoint(x:20, y: 120))
                            path.addLine(to: CGPoint(x: 160, y: 120))
                            path.addLine(to: CGPoint(x: 160, y: 20))
                        }
                        .stroke(.gray, lineWidth: 8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        Path() { path in
                            path.move(to: CGPoint(x: 20, y: 20))
                            path.addLine(to: CGPoint(x:20, y: 120))
                            path.addLine(to: CGPoint(x: 160, y: 120))
                            path.addLine(to: CGPoint(x: 160, y: 20))
                            path.closeSubpath()
                        }
                        .stroke(.gray, lineWidth: 8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        Path() { path in
                            path.move(to: CGPoint(x: 20, y: 20))
                            path.addLine(to: CGPoint(x:20, y: 120))
                            path.addLine(to: CGPoint(x: 160, y: 120))
                            path.addLine(to: CGPoint(x: 160, y: 20))
                        }
                        .fill(Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    }
                }
            
        } header: {
            HStack {
                Text("形状")
                    .font(.largeTitle)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(.white)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("基本显示")
            }
            .frame(height: 44)
            Divider()
            
            ScrollView {
                LazyVStack(spacing: 8, pinnedViews: .sectionHeaders) {
                    textView
                    imageView
                    webImageView
                    labelView
                    buttonView
                    shapeView
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGroupedBackground))
            
            Divider()
        }
    }
    
}

#Preview {
    BasicShowView()
}
