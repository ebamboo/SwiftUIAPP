//
//  OrganizationView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI

struct OrganizationView: View {
    
    @State var showNextPage = false
    @State var navigationIndex: Int? = nil
    
    @State var showAlert = false
    @State var showActionSheet = false
    @State var showModal = false
    @State var showFullModal = false
    
    var body: some View {
        VStack(spacing: 0) {
            Text("第二页")
                .frame(height: 44)
            Divider()
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
                    
                }
                
                Section {
                    
                    /// 运行测试，因为当前页面没有导航环境
                    
                    Button {
                        showNextPage = true
                    } label: {
                        Text("独立控制导航")
                    }
                    .push(isPresented: $showNextPage) {
                        Text("独立控制的导航详情页面")
                    }
                    
                    Button {
                        navigationIndex = 1
                    } label: {
                        Text("匹配控制导航一")
                    }
                    .push(selection: $navigationIndex, equals: 1) {
                        Text("一")
                    }
                    
                    Button {
                        navigationIndex = 2
                    } label: {
                        Text("匹配控制导航二")
                    }
                    .push(selection: $navigationIndex, equals: 2) {
                        Text("二")
                    }
                    
                    Button {
                        navigationIndex = 3
                    } label: {
                        Text("匹配控制导航三")
                    }
                    .push(selection: $navigationIndex, equals: 3) {
                        Text("三")
                    }
                    
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
                        CustomCloseView(disablesAnimations: true) {
                            Text("通过 dismiss 环境变量关闭视图")
                                .font(.title)
                                .foregroundStyle(.blue)
                        }
                    })
                    
                }  footer: {
                    Text("更多导航栈和模态栈相关的 dismiss 测试行为和解释请查看 CustomCloseView 文件。")
                }
                
                Section {
                    let text = """
                         关闭导航栈或者模态栈内的页面至指定页面。
                         通过创建一个环境变量对象，这个对象可以存储这样一些方法或者回调------关闭至指定页面；
                         在方便实现相应方法的地方实现相关方法，在需要调用的地方调用相关方法！！！
                         """
                    Text(text)
                }
                
            }
            Divider()
        }
    }
    
}

#Preview {
    OrganizationView()
}
