//
//  Rotation3DTest.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/27.
//

import SwiftUI

/*
 
 rotation3DEffect 立体旋转基本使用(注意被父视图截取导致效果不明显)
 一、坐标系和旋转方向确定：
 A、x、y、z轴坐标系的方向规则是这样的，x、y和iOS系统一致，z轴是从屏幕向着用户方向射出方向。
 B、围绕某个轴旋转时，是指：面向该轴的箭头方向，顺时针旋转参数 angle 角度；
 二、目前使用一下可以理解的、符合预期的操作如下：
 A、单独使用其中一个旋转轴；
 B、可以指定锚点anchor，如果延x轴旋转可选用top、center、bottom；如果延y轴旋转可选用leading、center、trailing，如果延z轴旋转（也即平面旋转），可选所有参数；
 C、如果延x或者y轴旋转时，可以设定 anchorZ，来控制旋转轴的在 z轴上的坐标。
 D、perspective 透视法（绘画相关技法），默认开启为1，可以设定为 0关闭透视法，这样会更符合预期。
 
 */
struct Rotation3DTest: View {
    
    let d = 11000.0
    
    var body: some View {
        VStack {
            Divider()
            ScrollView {
                
                HStack {
                    Spacer()
                    Text("把 Scroll 撑开") // 注意：不然变换之后超出父视图范围看不到效果
                    Spacer()
                }
                .frame(height: 44)
                
                Image(.low03)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .clipped()
                    .rotation3DEffect(
                        .radians(2 * atan(200/(2 * d))), // 计算出旋转多少弧度可以刚好相当于把视图平移了一个自身宽度，和 自身 width 和选择轴距离 d 有关；
                        axis: (x: 0, y: 1, z: 0),
                        anchor: .center,
                        anchorZ: -d,
                        perspective: 0 // 关闭透视法更符合预期
                    )
                    .border(Color.red)
                
                Image(.low03)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .rotation3DEffect(
                        .degrees(30),
                        axis: (x: 1, y: 0, z: 0),  // 延 x 轴旋转
                        anchor: .bottom, // 以底边为锚点
                        perspective: 1
                    )
                    .border(Color.red)
                
                Image(.low03)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .clipped()
                    .rotation3DEffect(
                        .degrees(-30),
                        axis: (x: 0, y: 1, z: 0), // 延 y 轴旋转
                        anchor: .center, // 以垂直中轴线为锚点
                        anchorZ: 0,
                        perspective: 1
                    )
                    .border(Color.red)
                
                Image(.low03)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .clipped()
                    .rotation3DEffect(
                        .degrees(30),
                        axis: (x: 0, y: 0, z: 1), // 延 z 轴旋转即平面旋转
                        anchor: .center, // 以 center 为旋转锚点
                        anchorZ: 0,
                        perspective: 1
                    )
                    .border(Color.red)
                
            }
            .frame(maxWidth: .infinity)
            .background(Color.cyan)
            Divider()
        }
    }
}

#Preview {
    Rotation3DTest()
}
