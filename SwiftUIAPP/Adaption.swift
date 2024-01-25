//
//  Adaption.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/23.
//

import SwiftUI

// MARK: - ===================

extension View {
    
    /// 监听值变化
    /// iOS 17.0 旧版本废弃，使用新版本
    @ViewBuilder func adaptionOnChange<V>(
        of value: V,
        perform action: @escaping (_ newValue: V) -> Void
    ) -> some View where V : Equatable {
        if #available(iOS 17.0, *) {
            onChange(of: value) { oldValue, newValue in
                action(newValue)
            }
        } else {
            onChange(of: value, perform: action)
        }
    }
    
    /// 隐藏系统默认的滑动视图内容的背景颜色
    /// iOS 16.0 之后才具有该功能，之前无法隐藏，因而无法修改滑动视图的背景颜色
    @ViewBuilder func adaptionScrollContentBackground(_ visibility: Visibility) -> some View {
        if #available(iOS 16.0, *) {
            scrollContentBackground(visibility)
        }
    }
    
}

// MARK: - ===================

struct AdaptionNavigationStack<Root: View>: View {
    
    @ViewBuilder var root: () -> Root
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(root: root)
        } else { // iOS 17.0 之后废弃
            NavigationView(content: root)
        }
    }
    
}

// MARK: - ===================

enum AdaptionPresentationDetent {
    case medium
    case large
    case fraction(_ fraction: CGFloat)
    case height(_ height: CGFloat)
}

extension View {
    
    /// 自定义模态高度
    /// iOS 16.0 之后才具有该功能
    @ViewBuilder func adaptionPresentationDetents(_ detents: [AdaptionPresentationDetent]) -> some View {
        if #available(iOS 16.0, *) {
            presentationDetents(
                Set(
                    detents.map({ item in
                        switch item {
                        case .medium:
                            PresentationDetent.medium
                        case .large:
                            PresentationDetent.large
                        case .fraction(let value):
                            PresentationDetent.fraction(value)
                        case .height(let value):
                            PresentationDetent.height(value)
                        }
                    })
                )
            )
        }
    }
    
}

// MARK: - ===================

///
/// 支持 placeholder 功能
/// 通过观察 text 动态改变前景颜色
///
struct AdaptionTextEditor: View {
    
    // MARK: - public
    
    @Binding var text: String
    
    var placeholder: String = ""
    var textColor: Color = .black
    var placeholderColor: Color = .gray
    
    // MARK: - life
    
    @FocusState private var isActive: Bool
    
    var body: some View {
        TextEditor(text: $text)
            .focused($isActive)
            .foregroundStyle(text == placeholder ? placeholderColor : textColor)
            .task(id: isActive) { // 视图加载后或者 isActive 变化时都会执行 action
                DispatchQueue.main.async {
                    if isActive { // 每次获得焦点时，判断是否隐藏 placeholder
                        if text == placeholder {
                            text = ""
                        }
                    } else { // 每次失去焦点时，判断是否应该展示 placeholder
                        if text == "" {
                            text = placeholder
                        }
                    }
                }
            }
    }
    
}
