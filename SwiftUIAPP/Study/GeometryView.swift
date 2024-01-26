//
//  GeometryView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/25.
//

import SwiftUI

struct GeometryView: View {
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            GeometryReader { geometry in
                ScrollView {
                    
                    VStack(spacing: 08) {
                        
                        let text1 = """
                              主要处理两类问：
                              1、按比例分配给子视图空间；
                              2、设置特定子类的宽高比；
                              """
                        Text(text1)
                            .background(.gray)
                        
                        let text2 = """
                              1、使用 .aspectRatio(.init(width: 1, height: 4), contentMode: .fit) 来处理等比例视图问题；
                              其中 size 表示宽高比例；结合 zstack，用 Rectangle()去撑起相应的尺寸；
                              设置目标视图的 frame 最大值为无限大，把它放入刚才的 zstack 中；
                              这个方案比 geometry 更像是 SwiftUI 方式更优雅；
                              注意：也要保证目标视图不要超过 Rectangle() 撑起的尺寸，不然再次撑大 zstack；
                              """
                        Text(text2)
                            .background(.gray)
                        
                        let text3 = """
                              Geometry 不会根据自身子视图的布局信息跟新自己的布局信息，只能由父视图容器直接分配给最大的空间；
                              如果父视图没提供，则使用 idea 尺寸；
                              """
                        Text(text3)
                            .background(.gray)
                        
                        let text4 = """
                              注意：
                              父视图会在两个方向上单独地提供可用尺寸；
                              如：在scrollview中，滑动方向的布局信息没法提供给geometry，
                              因为滑动方向的布局信息是无限大的,此时geometry会取idea尺寸；
                              """
                        Text(text4)
                            .background(.gray)
                        
                        Text("实现一个宽高比为 2:1 动态高度")
                            .frame(width: geometry.size.width, height: geometry.size.width/2)
                            .background(.gray)
                        
                        ZStack {
                            Rectangle()
                                .fill(.orange)
                                .aspectRatio(.init(width: 2, height: 1), contentMode: .fit)
                                .overlay {
                                    Text("2:1")
                                }
                                
                            // 目标视图
                        }
                        
                        Text("position 会返回一个新的视图，这个视图会占用所有可用空间（它修饰的视图的父视图所能提供的空间），然后才会布局它修饰的视图。")
                            .background(.gray)
                        
                        Rectangle()
                            .fill(.orange)
                            .frame(width: 260, height: 200)
                            .overlay {
                                GeometryReader { geo in
                                    Text("使用 position")
                                        .frame(width: 100, height: 44)
                                        .background(.gray)
                                        .position(x: 0, y: 100)
//                                        .background(.purple) // 注释看看
                                }
                            }
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.cyan)
            }
            Divider()
        }
    }
}

#Preview {
    GeometryView()
}
