//
//  LazyGridView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI

/*
 0：grid 本身视图会占用可用的最大空间；
 1：布局所有 fixed 的 items；
 2：去除所有 fixed 和 所有 item spacing 占用的空间（宽度），剩余的均分给所有的 （flexible、adaptive）；布局所有 flexible items；
 3、对于 adaptive 类型，在分配的确定空间（宽度）上，尽可能多地、均匀地布局多个子 item；满足条件：子 item 的宽度大于等于定义的最小宽度；
 
 一般地，adaptive 会根据实际情况设置最小值，其他设置使用默认值。
 */
struct LazyGridView: View {
    
    var body: some View {
        List {
            NavigationLink("fixed") {
                TestFiexdView()
            }
            
            NavigationLink("flexible") {
                TestFlexibleView()
            }
            
            NavigationLink("fixed 和 flexible组合") {
                TestView01()
            }
            
            NavigationLink("fixed、flexible、adaptive 三者组合") {
                TestView02()
            }
            
        }
    }
    
    struct TestFiexdView: View {
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                ScrollView {
                    LazyVGrid(
                        columns: [
                            .init(.fixed(100), spacing: 8),
                            .init(.fixed(100), spacing: 8),
                            .init(.fixed(100), spacing: 8),
                        ],
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                        spacing: 8,
                        pinnedViews: []
                    ) {
                        
                        ForEach(0...21, id: \.self) { i in
                            Rectangle()
                                .fill(.orange)
                                .frame(height: 100)
                                .frame(maxWidth: .infinity)
                        }
                        
                    }
                }
                .background(.cyan)
                Divider()
            }
        }
    }
    
    struct TestFlexibleView: View {
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                ScrollView {
                    LazyVGrid(
                        columns: [
                            .init(.flexible(), spacing: 8),
                            .init(.flexible(), spacing: 8),
                            .init(.flexible(), spacing: 8),
                        ],
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                        spacing: 8,
                        pinnedViews: []
                    ) {
                        
                        ForEach(0...21, id: \.self) { i in
                            Rectangle()
                                .fill(.orange)
//                                .frame(height: 100)
                                .aspectRatio(.init(width: 1, height: 1), contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        }
                        
                    }
                }
                .background(.cyan)
                Divider()
            }
        }
    }
    
    struct TestView01: View {
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                ScrollView {
                    LazyVGrid(
                        columns: [
                            .init(.flexible(), spacing: 8),
                            .init(.fixed(100), spacing: 8),
                            .init(.flexible(), spacing: 8),
                        ],
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                        spacing: 8,
                        pinnedViews: []
                    ) {
                        
                        ForEach(0...21, id: \.self) { i in
                            Rectangle()
                                .fill(.orange)
                                .frame(height: 100)
                                .frame(maxWidth: .infinity)
                        }
                        
                    }
                }
                .background(.cyan)
                Divider()
            }
        }
    }
    
    struct TestView02: View {
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                ScrollView {
                    LazyVGrid(
                        columns: [
                            .init(.fixed(100), spacing: 8),
                            .init(.flexible(), spacing: 8),
                            .init(.adaptive(minimum: 40, maximum: .infinity), spacing: 8),
                        ],
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                        spacing: 8,
                        pinnedViews: []
                    ) {
                        
                        ForEach(0...21, id: \.self) { i in
                            Rectangle()
                                .fill(.orange)
                                .frame(height: 100)
                                .frame(maxWidth: .infinity)
                        }
                        
                    }
                }
                .background(.cyan)
                Divider()
            }
        }
    }
    
}

#Preview {
    LazyGridView()
}
