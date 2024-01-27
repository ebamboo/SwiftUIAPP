//
//  TestView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/24.
//

import SwiftUI

struct TestView: View {
    

    @State var isLoading = false
    
    
    func testAction() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLoading = false
        }
    }
    
    var body: some View {
     
        
        List {
            Button {
                
            } label: {
                Text("test")
            }
            ForEach(0...24, id: \.self) { i in
                Text("===\(i)")
            }
        }
        .disabled(isLoading)
        .overlay {
            if isLoading {
                ProgressView()
            }
        }
        .refreshable {
            testAction()
        }
        
        
    }
    
}

#Preview {
    TestView()
}
