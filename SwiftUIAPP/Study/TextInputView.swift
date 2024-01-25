//
//  TextInputView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI
import UITextView_Placeholder

struct TextInputView: View {
    
    /// 管理输入框焦点
    enum ActiveField: Hashable {
        case account
        case password
        case profile
        case story
    }
    @FocusState var currentField: ActiveField?
    
    @State var account = ""
    @State var password = ""
    @State var profile = ""
    @State var story = ""
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("文字输入")
            }
            .frame(height: 44)
            Divider()
            
            Form {
                
                Section {
                    HStack {
                        Text("账号")
                        TextField("请输入账号", text: $account)
                            .keyboardType(.default)
                            .submitLabel(.next)
                            .focused($currentField, equals: .account)
                            .font(.system(size: 24))
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.blue)
                            .onSubmit {
                                currentField = .password
                            }
                    }
                } header: {
                    VStack(alignment: .leading) {
                        Text("单行文字输入")
                    }
                } footer: {
                    let text = """
                         1、通过 keyboardType 设置键盘类型;
                         2、通过 submitLabel 设置 return 键类型；
                         3、通过 focused 获取和设置焦点(当前活跃的输入框)；要使用 @FocusState 修饰变量;
                         4、通过 onSubmit 事件处理提交;
                         5、通过 binding 数据做各种验证;
                         """
                    Text(text)
                }
                
                Section {
                    HStack {
                        Text("密码")
                        SecureField("请输入密码", text: $password)
                            .keyboardType(.alphabet)
                            .submitLabel(.next)
                            .focused($currentField, equals: .password)
                            .onSubmit {
                                currentField = .profile
                            }
                    }
                } header: {
                    Text("密码输入")
                } footer: {
                    VStack(alignment: .leading) {
                        Text("基本功能和设置与 TextField 相同")
                        Text("目前没有隐藏和显示密码功能，需要时桥接 UITextField")
                    }
                }
                
                Section {
                    Text("自我介绍")
                    AdaptionTextEditor(text: $profile, placeholder: "~ 简单介绍一下自己吧")
                        .keyboardType(.numberPad)
                        .submitLabel(.done)
                        .focused($currentField, equals: .profile)
                        .frame(minHeight: 80)
                        .adaptionScrollContentBackground(.hidden) // iOS 16 才会生效
                        .background(Color(UIColor.systemGroupedBackground))
                        .padding(.vertical, 8)
                } header: {
                    Text("多行文字输入")
                } footer: {
                    VStack(alignment: .leading) {
                        let text = """
                              一、功能说明
                              1、通过 keyboardType 设置键盘类型;
                              2、多行输入框的 return 键功能为换行，设置 submitLabel 无意义；
                              3、因为上面的原因，TextEditor 不会响应 onSubmit 事件；
                              """
                        Text(text)
                        Text("二、适配 placeholder")
                        Text("1、通过比对输入的文字是否等于设定的 placeholder 动态改变文字颜色")
                        Text("2、每次获得焦点时, 如果文字还是等于 placeholder 则置为空字符串；")
                        + Text("没有获得焦点时，如果文字为空，则置为 placeholder")
                        Text("3、注意：无法修改背景颜色，会被 ScrollContentColor 遮挡，要么使用新api隐藏这个颜色，要么桥接UITextView")
                    }
                }
                
                Section {
                    Text("故事背景")
                    BridgeTextEditor(text: $story) { textView in
                        textView.font = .systemFont(ofSize: 17)
                        textView.textColor = .red
                        textView.placeholder = "请写下您的故事"
                        textView.backgroundColor = .systemGroupedBackground
                        textView.returnKeyType = .done
                    }
                    .focused($currentField, equals: .story)
                    .frame(minHeight: 80)
                    .padding(.vertical, 8)
                } header: {
                    Text("桥接UITextView")
                } footer: {
                    let text = """
                         支持更多属性配置;
                         支持 focused 功能;
                         会尽可能地占用更多可用空间;
                         
                         注意：根据 autoSize 不同情况设置不同的布局；
                         true：不可以设置 height 或者 maxHeight，否则可能会超出视图显示范围；可以设置 minHeight；
                         false：设置 height 或者 minHeight 为实际高度；设置 maxHeigh 无效；
                         """
                    Text(text)
                }
                
                Section {
                    let text = """
                         使用 ToolBar 在键盘上方添加完成按钮关闭键盘；
                         桥接 UITextView 之后，ToolBar 不对它生效，需要手动添加 ToolBar；唤起键盘时也容易遮挡桥接的 UITextView;
                         因此谨慎使用桥接版本，只在必要时使用；
                         """
                    Text(text)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Button("Cancel") {
                            currentField = nil
                        }
                        Spacer()
                        Button("Ok") {
                            currentField = nil
                            print("======提交操作")
                        }
                    }
                }
            }
            
            Divider()
        }
    }
    
}

#Preview {
    TextInputView()
}
