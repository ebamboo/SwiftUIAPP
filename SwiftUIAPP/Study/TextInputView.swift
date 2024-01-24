//
//  TextInputView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI

struct TextInputView: View {
    
    /// 管理输入框焦点
    enum ActiveField: Hashable{
        case account
        case password
        case profile
    }
    @FocusState var currentField: ActiveField?
    
    @State var account = ""
    @State var password = ""
    @State var profile = ""
    
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
                        Text("可以桥接 UITextField")
                    }
                } footer: {
                    VStack(alignment: .leading) {
                        Text("1、设置键盘类型")
                        Text("2、设置 return 键类型")
                        Text("3、通过 focused 获取和设置焦点(当前活跃的输入框)；要使用 @FocusState 修饰变量")
                        Text("4、通过 onSubmit 事件处理提交")
                        Text("5、通过 binding 数据做各种验证")
                    }
                    
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
                }
                
                Section {
                    Text("自我介绍")
                    AdaptionTextEditor(text: $profile, placeholder: "~ 简单介绍一下自己吧")
                        .focused($currentField, equals: .profile)
                        .frame(minHeight: 80)
                        .adaptionScrollContentBackground(.hidden) // iOS 16 才会生效
                        .background(Color(UIColor.systemGroupedBackground))
                        .padding(.vertical, 8)
                } header: {
                    VStack(alignment: .leading) {
                        Text("多行文字输入")
                        Text("可以桥接 UITextView")
                    }
                } footer: {
                    VStack(alignment: .leading) {
                        Text("1、通过比对输入的文字是否等于设定的 Placeholder 动态改变文字颜色")
                        Text("2、每次获得焦点时, 如果文字还是等于 Placeholder 则置为空字符串；")
                        + Text("没有获得焦点时，如果文字为空，则置为 Placeholder")
                        Text("3、注意：无法修改背景颜色，会被 ScrollContentColor 遮挡，要么使用新api隐藏这个颜色，要么桥接UITextView")
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
