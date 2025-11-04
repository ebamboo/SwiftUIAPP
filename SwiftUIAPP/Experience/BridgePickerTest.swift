//
//  BridgePickerTest.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/26.
//

import SwiftUI
import BRPickerView

struct BridgePickerTest: View {
    
    @State var seletedIndex: Int?
    @State var optionList: [String] = ["0", "1", "2", "3"]
    
    var body: some View {
        
        VStack {
            
            Button("添加数据") {
                optionList.append("4")
                optionList.append("5")
            }
            
            Text("选择了\(seletedIndex ?? -1)")
            
            Button("选择试试") {
                let picker = BRStringPickerView()
                picker.title = "单选"
                picker.dataSourceArr = optionList
                picker.cancelBlock = {
                    
                }
                picker.doneBlock = {
                   
                }
                picker.resultModelBlock = { model in
                    seletedIndex = model?.index
                }
                picker.show()
            }
            
        }
    }
}

#Preview {
    BridgePickerTest()
}
