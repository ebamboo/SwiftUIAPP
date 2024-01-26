//
//  OrganizationView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI

struct OrganizationView: View {
    
    
    
    @State var showAlert = false
    @State var showActionSheet = false
    @State var showModal = false
    @State var showFullModal = false
    
    var body: some View {
        List {
            
            Section {
                
                let text1 = """
                    说明：
                    1、tabview 和 navigation 核心功能是组织和导航，它们对应的 bar 只是一个方便功能，因此根据可实际情况隐藏自定义；
                    2、一般项目都会隐藏导航栏，自定义一个高度灵活、可控制的 bar；标签栏可视情况决定是否隐藏并自定义；
                    """
                Text(text1)
                
                let text2 = """
                    有两种组织结构：
                    1、tabview 包裹着 navigation。
                    这种方式是自热的，然而在 SwiftUI 中我们不能优雅的隐藏标签栏。
                    2、navigation 包裹着 tabview。
                    这种方式本质是用 tabview 作为 navigation 的 root，导航至下一页时，自热而然的就会把 tabview 整体覆盖遮挡---也即隐藏了标签栏。
                    """
                Text(text2)
                
                let text3 = """
                    pop 至指定页面。
                    这个需求无论在 UIKit 中还是 SwiftUI 中，都要思考如何清晰明确的描述要 pop 至的页面。
                    需要说明的是，这不是一个常用功能，虽然它可能是必需的。
                    在 UIKit 中我们并没有无歧义的做这件事情，只是简单计算 Index 或者 判断一下类型，这可以工作，但可能会出问题；
                    在 SwiftUI 中，我们可以借助环境变量，把需要导航的页面的控制显示与否的数据放入环境中，在需要的地方修改这个数据既可以达到 pop 指定页面功能。
                    很显然，如果大量使用该功能（实际上这个需求并不是很多）会导致很多环境变量处理该问题；
                    """
                Text(text3)
                
            }
            
            Section {
                
                //---------
                HStack {
                    Text("alert")
                    Spacer()
                }
                .contentShape(.rect)
                .onTapGesture {
                    showAlert = true
                }
                .alert("这个是alert", isPresented: $showAlert) {
                    Button("cancel") {
                        
                    }
                    Button("ok") {
                        
                    }
                } message: {
                    Text("可选的具体的message信息")
                }
                
                //---------
                HStack {
                    Text("action sheet")
                    Spacer()
                }
                .contentShape(.rect)
                .onTapGesture {
                    showActionSheet = true
                }
                .confirmationDialog("title：这是个 action sheet", isPresented: $showActionSheet, titleVisibility: .visible) {
                    Button("1") {
                        
                    }
                    Button("2") {
                        
                    }
                } message: {
                    Text("message： 使用新的 api 了")
                }
                
                //---------
                HStack {
                    Text("modal sheet")
                    Spacer()
                }
                .contentShape(.rect)
                .onTapGesture {
                    showModal = true
                }
                .sheet(isPresented: $showModal, content: {
                    VStack(content: {
                        Text("Modal")
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.gray)
                    .adaptionPresentationDetents([.medium, .large]) // 注意使用的区域
                })
                
                //---------
                HStack {
                    Text("full modal sheet")
                    Spacer()
                }
                .contentShape(.rect)
                .onTapGesture {
                    // 关闭展示动画
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        showFullModal = true
                    }
                }
                .fullScreenCover(isPresented: $showFullModal, content: {
                    TestFullDetail()
                })
            }
            
        }
    }
    
    struct TestFullDetail: View {
        
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            Button("通过 dismiss 环境变量关闭视图") {
                // 关闭 dismiss 动画
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    dismiss()
                }
            }
        }
        
    }
    
}

#Preview {
    OrganizationView()
}
