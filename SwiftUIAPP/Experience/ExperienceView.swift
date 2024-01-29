//
//  ExperienceView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI

struct ExperienceView: View {
    
    let itemList = [
        "桥接FSPagerView轮播图",
        "桥接 TZImagePickerController 视频图片选择器",
        "自定义标签菜单(SegmentView)\n配合TabView实现联动分页效果",
        "桥接 BRPickerView 选择器",
        "使用 TabView 分页方式作为图片浏览器", // 还是桥架UIKit中的第三方库吧（可能要想办法搞到 window）
        "获取ScrollView偏移量",
        "下拉刷新/上拉加载更多",
        "模态选择器",
        "系统文件分享",
        "SwiftUI截取视图",
        "3D旋转 rotation3DEffect",
        "列表中网络图片优化",
        "实现一个 Toast 工具",
        "待解决问题或者解决方式不优雅"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("实践")
            }.frame(height: 44)
            Divider()
            
            List(0..<itemList.count, id: \.self) { index in
                NavigationLink(destination: makeViewForNavigtion(index: index)) {
                    Text(itemList[index])
                }
            }
            
            Divider()
        }
    }
    
    @ViewBuilder func makeViewForNavigtion(index: Int) -> some View {
        switch index {
        case 0: BridgePagerViewTest()
        case 1: BridgeImgaPickerTest()
        case 2: TabViewTest()
        case 3: BridgePickerTest()
        case 4: ImageBrowserTest()
        case 5: ScrollOffsetTest()
        case 6: ScrollRefreshTest()
        case 7: PickerPageTest()
        case 8: SharePageTest()
        case 9: SnapShotViewTest()
        case 10: Rotation3DTest()
        case 11: WebImageListTest()
        case 12: CustomToastTest()
        case 13: QuestionView()
        default: EmptyView()
        }
    }
    
}

#Preview {
    ExperienceView()
}
