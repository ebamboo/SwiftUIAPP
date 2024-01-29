//
//  CustomCloseView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/28.
//

import SwiftUI

struct CustomCloseView<Content: View>: View {
    
    @ViewBuilder var content: () -> Content
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        content()
            .onTapGesture {
                dismiss()
            }
    }
    
}
