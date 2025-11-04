//
//  CustomCloseView.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/28.
//

import SwiftUI

/*
 dismiss 所处环境只能是 导航栈NavigationStack 或者 模态栈ModalStack 其中一个；
 其中处在导航栈管理的 root 中时，调用无效;（导航栈必须有一个root，root不能pop）
 */
struct CustomCloseView<Content: View>: View {
    
    var disablesAnimations = false
    @ViewBuilder var content: () -> Content
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        content()
            .onTapGesture {
                if disablesAnimations {
                    // 关闭 dismiss 动画
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        dismiss()
                    }
                } else {
                    dismiss()
                }
            }
    }
    
}

/// 可通过数据控制是否关闭页面
struct BindingCloseView<Content: View>: View {
    
    @Binding var close: Bool
    var disablesAnimations = false
    @ViewBuilder var content: () -> Content
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        content()
            .onTapGesture {
                closeAction()
            }
            .adaptionOnChange(of: close) { newValue in
                if newValue { closeAction() }
            }
    }
    
    private func closeAction() {
        if disablesAnimations {
            // 关闭 dismiss 动画
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                dismiss()
            }
        } else {
            dismiss()
        }
    }
    
}

// MARK: - ===================================

private struct CustomCloseView_Test: View {
    
    @State var showModal01 = false
    
    @State var showModal02 = false
    
    var body: some View {
        VStack(spacing: 40) {
            Button {
                showModal01 = true
            } label: {
                Text("弹出一个普通模特视图")
                    .font(.title)
            }
            .sheet(isPresented: $showModal01, content: {
                View01()
            })
            
            Button {
                showModal02 = true
            } label: {
                Text("弹出一个导航栏模特视图")
                    .font(.title)
            }
            .sheet(isPresented: $showModal02, content: {
                View03()
            })
        }
    }
    
}

private extension CustomCloseView_Test { // 简单演示

    struct View01: View {
        
        @State var showNextPage = false
        
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            VStack(spacing: 20) {
                Text("第一页")
                Button {
                    dismiss()
                } label: {
                    Text("关闭当前页面")
                }
                Spacer()
                Button {
                    showNextPage = true
                } label: {
                    Text("点击进入下一页")
                }
                .sheet(isPresented: $showNextPage, content: {
                    View02()
                })
            }
            .frame(height: 400)
        }
        
    }
    
    struct View02: View {
        
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            VStack(spacing: 20) {
                Text("第二页")
                Button {
                    dismiss()
                } label: {
                    Text("关闭当前页面")
                }
                Spacer()
            }
            .frame(height: 400)
        }
        
    }
    
}

private extension CustomCloseView_Test { // 演示模态弹出一个导航栏情况

    struct View03: View {
        
        @State var showNextPage = false
        
        @Environment(\.dismiss) private var dismiss // 所处环境为模态栈的某个页面 -- View03
        
        var body: some View {
            NavigationView {
                VStack(spacing: 20) {
                    Text("第一页")
                    Button {
                        dismiss() // 注意对比，View03 的环境可以调用 dismiss；View03 自身并不是导航栈，只是他的 body 包含导航栈；
                    } label: {
                        Text("关闭当前页面")
                    }
                    CustomCloseView { // 注意观察，此处所在环境为导航栈的 root 中，调用 dismiss 无效。
                        Text("观察环境变量所在环境：关闭页面")
                            .foregroundStyle(.blue)
                    }
                    Spacer()
                    Button {
                        showNextPage = true
                    } label: {
                        Text("点击进入下一页")
                    }
                    .push(isPresented: $showNextPage) {
                        View04()
                    }
                }
                .frame(height: 400)
            }
        }
        
    }
    
    struct View04: View {
        
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            VStack(spacing: 20) {
                Text("第二页")
                Button {
                    dismiss()
                } label: {
                    Text("关闭当前页面")
                }
                Spacer()
            }
            .frame(height: 400)
        }
        
    }
    
}

// MARK: - ===================================

#Preview {
    CustomCloseView_Test()
}
