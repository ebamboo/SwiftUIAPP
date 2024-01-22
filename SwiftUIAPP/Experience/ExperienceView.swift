//
//  ExperienceView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI

struct ExperienceView: View {
    
    let itemList = [
        "桥接UIKit轮播图",
        "桥接UIKit视频图片选择器",
        "自定义标签菜单(SegmentView)\n配合TabView实现联动分页效果",
        "获取ScrollView偏移量",
        "模态选择器",
        "系统文件分享",
        "SwiftUI截取视图",
        "3D旋转 rotation3DEffect"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("实践")
            }.frame(height: 44)
            Divider()
            
            List(0..<itemList.count, id: \.self) { index in
                Text(itemList[index])
            }
            
            Divider()
        }
    }
    
}

#Preview {
    ExperienceView()
}
