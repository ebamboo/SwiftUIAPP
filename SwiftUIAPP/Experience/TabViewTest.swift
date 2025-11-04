//
//  TabViewTest.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/26.
//

import SwiftUI

struct TabViewTest: View {
    
    @State var selectedIndex = 0
    
    @State var menuList: [String] = [
        "推荐", "要闻", "视频", "抗疫", "北京",
        "新时代", "娱乐", "体育", "军事", "NBA",
        "科技", "财经", "时尚"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            SegementView(
                selectedIndex: $selectedIndex,
                spacing: 0.0,
                indicatorColor: .orange,
                indicatorHeight: 2,
                indicatorWidth: nil,
                indicatorOffset: 3
            ) {
                
                ForEach(0..<menuList.count, id: \.self) { index in
                    Text(menuList[index])
                        .scaleEffect(index == selectedIndex ? 1.5 : 1.0)
                        .foregroundColor(index == selectedIndex ? Color.orange : Color.black)
                        .padding(.all, 8)
                        .anchorPreference(key: SegementPreferenceKey.self, value: .bounds, transform: { anchor in
                            [SegementPreferenceData(itemViewIndex: index, itemViewBounds: anchor)]
                        })
                        .onTapGesture {
                            withAnimation {
                                selectedIndex = index
                            }
                        }
                }
                
            }
            .frame(height: 50)
            
            Divider()
            
            TabView(selection: $selectedIndex) {
                ForEach(0..<menuList.count, id: \.self) { index in
                    Text("第\(index)页面").tag(index)
                        .background(.gray)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Divider()
        }
    }
    
}

#Preview {
    TabViewTest()
}
