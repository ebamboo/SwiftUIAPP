//
//  MultiPickerView.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/22.
//

import SwiftUI
import Photos

struct MultiPickerView: View {
    
    @State var isOn = false
    @State var shoppingNum = 0
    @State var voice = 75.0
    
    @State var selectedDate1 = Date.now
    @State var selectedDate2 = Date.now
    @State var selectedColor = Color.clear
    @State var selectedImages: [(UIImage, PHAsset)] = []
    
    @State var optionList = ["选项一", "选项二", "选项三", "选项四"]
    @State var selectedOption1 = -1
    @State var selectedOption2 = 2
    @State var selectedOption3: Int? = 1
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("多功能选择")
            }
            .frame(height: 44)
            Divider()
            
            Form {
                
                Section {
                    
                    Toggle(isOn: $isOn) {
                        Text("是否开启")
                    }
                    
                    Stepper(value: $shoppingNum, in: 0...11, step: 2) {
                        Text("编辑购物车数量：\(shoppingNum)")
                    } onEditingChanged: { changed in
                        print(changed ? "变化了" : "没变化")
                    }
                    
                    VStack {
                        Text("控制音量：\(voice)")
                        Slider(value: $voice, in: 1...100, step: 1) { // value 必须是浮点数
                            Text("默认不显示")
                        } minimumValueLabel: {
                            Image(systemName: "speaker.minus")
                        } maximumValueLabel: {
                            Image(systemName: "speaker.plus")
                        } onEditingChanged: { changed in
                            print(changed ? "变化了" : "没变化")
                        }
                    }
                    
                }
                
                Section {
                    
                    NavigationLink {
                        let text = """
                              1、参考饿了么、美团外卖、肯德基地址添加管理功能；
                              2、联系信息一般包括：联系人(可有男士/女士选项)、手机号、地址、门牌号、可选的标签；
                              3、选择地址：在一定的范围内（城市或者县）通过关键字或者经纬度（map上的点）获取POI；
                              不要考虑搜不到POI的情况，此种情况说明业务也没必要支持此处了；
                              4、通过POI获取一下信息：
                              a、省市区街道；b、地址编码；c、POI名称；d、经纬度；
                              """
                        Text(text)
                    } label: {
                        Text("选择地址")
                    }
                    
                    DatePicker(selection: $selectedDate1, in: Date.now...Date.now.addingTimeInterval(60*60*24*30), displayedComponents: [.date, .hourAndMinute]) {
                        Text("选择时间")
                    }
                    
                    HStack {
                        Text("自定义模态选择时间")
                        Spacer()
                        CustomDatePicker(date: $selectedDate2) {
                            Text("选择的时间:\(selectedDate2)")
                                .foregroundStyle(.blue)
                        }
                    }
                    
                    ColorPicker(selection: $selectedColor, label: {
                        Text("选择颜色")
                    })
                    
                    HStack {
                        Text("选择图片")
                        Spacer()
                        CustomImagePicker(configration: .init(), selectedAssets: Binding<[PHAsset]>(
                            get: { selectedImages.map({ $0.1 }) },
                            set: { _ in }
                        )) {
                            Text("已经选择了：\(selectedImages.count)")
                                .foregroundStyle(.blue)
                        } completion: { infoList in
                            selectedImages = infoList
                        }
                    }
                    
                }
                
                Section {
                    
                    Picker(selection: $selectedOption1) {
                        Text("请选择").tag(-1).foregroundStyle(.gray)
                        ForEach(0..<optionList.count, id: \.self) { i in
                            Text(optionList[i]).tag(i)
                        }
                    } label: {
                        Text("menu")
                    }
                    .pickerStyle(.menu)
                    .tint(selectedOption1 == -1 ? .gray : .black)
                    
                    VStack {
                        Text("wheel")
                        Picker(selection: $selectedOption2) {
                            ForEach(0..<optionList.count, id: \.self) { i in
                                Text(optionList[i]).id(i)
                            }
                        } label: {
                            
                        }
                        .pickerStyle(.wheel)
                        .labelsHidden()
                    }
                    
                    VStack {
                        Text("segmented")
                        Picker(selection: $selectedOption2) {
                            ForEach(0..<optionList.count, id: \.self) { i in
                                Text(optionList[i]).id(i)
                            }
                        } label: {
                            
                        }
                        .labelsHidden()
                        .pickerStyle(.segmented)
                    }
                    
                    Picker(selection: $selectedOption2) {
                        ForEach(0..<optionList.count, id: \.self) { i in
                            Text(optionList[i]).id(i)
                        }
                    } label: {
                        Text("inline")
                    }
                    .pickerStyle(.inline)
                    
                } footer: {
                    Text("实际开发中，使用Menu或者menu样式的选择器比较实用，因为可以为空")
                }
                
                Section {
                    
                    HStack {
                        Text("通过Menu选择")
                        Spacer()
                        TestMenuPicker(selectedIndex: $selectedOption3, optionList: $optionList)
                    }
                    
                }
                
            }
            
            Divider()
        }
    }

    struct TestMenuPicker: View {
        
        @Binding var selectedIndex: Int?
        @Binding var optionList: [String]
        
        var body: some View {
            Menu {
                
                ForEach(0..<optionList.count, id: \.self) { i in
                    Button {
                        if selectedIndex == i {
                            selectedIndex = nil
                        } else {
                            selectedIndex = i
                        }
                    } label: {
                        Label(
                            title: { Text(optionList[i]) },
                            icon: {
                                if selectedIndex == i {
                                    Image(systemName: "checkmark")
                                }
                            }
                        )
                    }
                }
                
                
            } label: {
                Text(selectedIndex == nil ? "请通过Menu选择" : optionList[selectedIndex!])
                    .foregroundStyle(selectedIndex == nil ? .gray : .blue)
            }

        }
        
    }
    
}

#Preview {
    MultiPickerView()
}
