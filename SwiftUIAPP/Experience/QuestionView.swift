//
//  QuestionView.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/29.
//

import SwiftUI

struct QuestionView: View {
    var body: some View {
        
        let text = """
          1、ScrollView 底部加载更多；
          a、加大每页大数量；b、手动加载更多；
          2、SwiftUI 视图截图效果不稳定；
          """
        Text(text)
    }
}

#Preview {
    QuestionView()
}
