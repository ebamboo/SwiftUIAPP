//
//  SegementView.swift
//  SwiftDemo01
//
//  Created by 姚旭 on 2024/1/15.
//

import SwiftUI

struct SegementView<Content>: View where Content: View  {
    
    @Binding var selectedIndex: Int
    
    var spacing = 0.0
    
    var indicatorColor = Color.clear // 如果不需要 indicator 可以设置为 clear
    var indicatorHeight = 3.0
    var indicatorWidth: Double? = nil // nil 表示和选项卡宽度对齐
    var indicatorOffset: Double? = nil // 垂直方向的偏移量，大于 0 表示向下偏移；nil 表示无偏移和选项卡 bottom 对齐；
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack(spacing: spacing, content: content)
                    .onChange(of: selectedIndex) { value in
                        withAnimation {
                            proxy.scrollTo(value, anchor: .none)
                        }
                    }
            }
        }
        .backgroundPreferenceValue(SegementPreferenceKey.self) { values in
            GeometryReader { proxy in
                indicator(with: values, proxy: proxy)
            }
        }
    }
    
    @ViewBuilder func indicator(with itemViewDataList: [SegementPreferenceData], proxy: GeometryProxy) -> some View {
        if let selectedItemViewData = itemViewDataList.first(where: { $0.itemViewIndex == selectedIndex }) {
            let bounds = proxy[selectedItemViewData.itemViewBounds]
            RoundedRectangle(cornerRadius: 2.5)
                   .fill(indicatorColor)
                   .frame(
                    width: indicatorWidth ?? bounds.width,
                    height: indicatorHeight
                   )
                   .offset(
                    x: bounds.origin.x + (bounds.width - (indicatorWidth ?? bounds.width)) / 2,
                    y: bounds.height - indicatorHeight + (indicatorOffset ?? 0)
                   )
        }
    }
    
}

struct SegementPreferenceData {
    let itemViewIndex: Int
    let itemViewBounds: Anchor<CGRect>
}

struct SegementPreferenceKey: PreferenceKey {
    static var defaultValue: [SegementPreferenceData] { [] }
    static func reduce(value: inout [SegementPreferenceData],
                       nextValue: () -> [SegementPreferenceData]
    ) {
        value.append(contentsOf: nextValue())
    }
}
