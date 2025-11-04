//
//  ToastView.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/2/2.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func toast(
        state: Binding<ToastState>,
        duration: Double = 2,
        toastView: @escaping () -> some View
    ) -> some View {
        modifier(
            ToastModifier(
                state: state,
                duration: duration,
                toastView: toastView
            )
        )
    }
    
    @ViewBuilder
    func loading(isPresented: Binding<Bool>) -> some View {
        modifier(LoadingModifier(isPresented: isPresented))
    }
    
}

/*
 ！！！通过方法修改属性，否则可能监听不到变化！！！
 */
enum ToastState: Equatable {
    
    case hidden
    case visible(count: UInt)
    
    mutating func hide() {
        self = .hidden
    }
    
    mutating func show() {
        switch self {
        case .hidden:
            self = .visible(count: 0)
        case .visible(let count):
            if count == UInt.max {
                self = .visible(count: 0)
            } else {
                self = .visible(count: count+1)
            }
        }
    }

}

struct ToastModifier<ToastView: View>: ViewModifier {
    
    // MARK: - public
    
    @Binding var state: ToastState
    
    @State var duration: Double = 2
    
    @ViewBuilder var toastView: () -> ToastView
    
    // MARK: - life
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if state == .hidden { // 保证初始化，不然初始化时数据不会更新
                    toastView().hidden()
                } else {
                    toastView()
                }
            }
            .adaptionOnChange(of: state) { newValue in
                stateChangeAction(with: newValue)
            }
    }
    
    @State private var workItem: DispatchWorkItem?
    
    func stateChangeAction(with newState: ToastState) {
        workItem?.cancel()
        guard newState != .hidden else { return }
        let task = DispatchWorkItem {
            withAnimation {
                state.hide()
                workItem = nil
            }
        }
        workItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: task)
    }
    
}

struct LoadingModifier: ViewModifier {
    
    // MARK: - public
    
    @Binding var isPresented: Bool
    
    // MARK: - life
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
                    ActivityIndicator()
                        .frame(width: 100, height: 100)
                        .background { Color.black.opacity(0.76) }
                        .clipShape(.rect(cornerRadius: 8))
                }
            }
    }
    
    // MARK: - 桥接 UIKit Loading View
    
    struct ActivityIndicator: UIViewRepresentable {
        func makeUIView(context: Context) -> UIActivityIndicatorView {
            let loadingView = UIActivityIndicatorView()
            loadingView.style = .large
            loadingView.color = .white
            loadingView.startAnimating()
            return loadingView
        }
        func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
    }
    
}
