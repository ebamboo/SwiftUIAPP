//
//  CustomToastTest.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/29.
//

import SwiftUI

struct CustomToastTest: View {
 
    @State var toasState = ToastState.hidden
    @State var isLoading = false
    
    @State var message = "初始测试 message"
    
    var body: some View{
        
        VStack(spacing: 30) {
            
            Button {
                isLoading = true
            } label: {
                Text("开始 Loading ")
            }
            
            Button {
                isLoading = false
            } label: {
                Text("结束 Loading ")
            }
            
            Spacer()
            
            Button {
                message = "1111111111111"
                toasState.show()
            } label: {
                Text("第1个 message ")
            }
            
            Button {
                message = "2222222222222222222222222222222222222222222"
                toasState.show()
            } label: {
                Text("第2个 message ")
            }
            
            Button {
                toasState.hide()
            } label: {
                Text("关闭 Toast ")
            }
            
        }
        .frame(maxWidth: .infinity)
        .loading(isPresented: $isLoading)
        .toast(state: $toasState) {
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding()
                .background(.black.opacity(0.8))
                .clipShape(.rect(cornerRadius: 8))
        }
       
    }
    
}

#Preview {
    CustomToastTest()
}
