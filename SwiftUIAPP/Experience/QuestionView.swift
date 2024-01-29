//
//  QuestionView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/29.
//

import SwiftUI

struct QuestionView: View {
    var body: some View {
        
        let text = """
          1、图片或者视频浏览器：
          目前可以想办法获取 window，使用自己或者第三方的浏览器；
          2、SwiftUI 视图截图效果不稳定；
          3、导航栈或者模态栈返回指定页面测试不充分；
          """
        Text(text)
    }
}

#Preview {
    QuestionView()
}
