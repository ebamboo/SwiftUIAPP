//
//  NavigationPush.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/29.
//

import SwiftUI

extension View {
    
    /*
     编程的方式导航页面
     
     目前仍然要使用这些关于导航栏的过期 API，因为要兼容新老项目；
     实际项目中很难保证使用的导航栏是 NavigationStack 还是 NavigationView，甚至是 UIKit 版本的导航栏；
     新版本 API 是不兼容这些老版本的导航栏的，因此继续使用这些不推荐的 API；
     */
    @ViewBuilder func push<V>(isPresented: Binding<Bool>, @ViewBuilder destination: () -> V) -> some View where V : View {
        background {
            NavigationLink(isActive: isPresented, destination: destination, label: {}).hidden()
        }
    }
    
    @ViewBuilder func push<D, V>(selection: Binding<D?>, equals: D, @ViewBuilder destination: () -> V) -> some View where D : Hashable, V : View {
        background {
            NavigationLink(tag: equals, selection: selection, destination: destination, label: {}).hidden()
        }
    }
    
}
