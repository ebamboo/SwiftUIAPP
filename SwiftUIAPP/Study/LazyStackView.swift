//
//  LazyStackView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI

struct LazyStackView: View {
    // 注意观察顶部和尾部吸附情况
    // 保证所有 cell id 唯一！！！！！！！
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                    
                    ForEach(1...10, id: \.self) { count in
                        
                        Section {
                            
                            ForEach(0...4, id: \.self) { i in
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("=====\(i)").frame(height: 44)
                                    Divider()
                                }
                                .padding(.leading)
                                    .id("\(count)-\(i)")
                                    .frame(maxWidth: .infinity)
                                    .background(.orange)
                            }
                            
                            
                        } header: {
                            Text("第 \(count) 项目头")
                                .frame(height: 44)
                                .frame(maxWidth: .infinity)
                                .background(.gray)
                        } footer: {
                            Text("第 \(count) 项目尾")
                                .frame(height: 44)
                                .frame(maxWidth: .infinity)
                                .background(.cyan)
                        }
                        
                    }
                    
                }
            }
            Divider()
        }
    }
}

#Preview {
    LazyStackView()
}
