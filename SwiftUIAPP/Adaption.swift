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
        } else {
            self
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

// MARK: - ===================

extension View {
    
    /// 截取视图输出 UIImage
    /// ！！！截取时注意截取的视图尺寸保持不变！！！
    /// 包括系统封装的截图工具都会出现尺寸超预期的情况，
    /// 在实际使用中尽量把各种尺寸都固定下来，减少变形的情况
    /// 多测试多测试
    ///
    /// 设置要截取的视图忽略安全区域；不要使用 padding；
    /// ！！！尽量固定尺寸！！！
    func adaptionSnapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
}

// MARK: - ===================

enum AdaptionShareItemType {
    case text(_ text: String)
    case url(_ url: URL) // 网址链接或者本地文件路径
    case image(_ image: UIImage)
}

struct AdaptionShareLink<Content>: View where Content: View { // 不能控制是否应该弹出分享页面
    
    typealias CompletionHandler = (UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void
    
    let items: [AdaptionShareItemType]
    @ViewBuilder var content: () -> Content
    let completion: CompletionHandler?
    
    init(items: [AdaptionShareItemType], @ViewBuilder content: @escaping () -> Content, completion: CompletionHandler? = nil) {
        self.items = items
        self.content = content
        self.completion = completion
    }
    init(items: AdaptionShareItemType..., @ViewBuilder content: @escaping () -> Content, completion: CompletionHandler? = nil) {
        self.items = items
        self.content = content
        self.completion = completion
    }
    
    @State private var showShareView = false
    
    var body: some View {
        content()
            .onTapGesture {
                guard !items.isEmpty else { return }
                showShareView = true
            }
            .sheet(isPresented: $showShareView) {
                AdaptionShareView(items: items, completion: completion)
            }
    }
    
}

struct AdaptionShareView: UIViewControllerRepresentable { // 可以控制是否应该弹出分享页面
    
    typealias CompletionHandler = (UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void
    
    let items: [AdaptionShareItemType]
    let completion: CompletionHandler?
    
    init(items: [AdaptionShareItemType], completion: CompletionHandler? = nil) {
        self.items = items
        self.completion = completion
    }
    init(items: AdaptionShareItemType..., completion: CompletionHandler? = nil) {
        self.items = items
        self.completion = completion
    }
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityItems: [Any] = items.map { item in
            switch item {
            case .text(let text):
                return text
            case .url(let url):
                return url
            case .image(let image):
                return image
            }
        }
        let activityViewController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        activityViewController.completionWithItemsHandler = completion
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
    
}
