//
//  PresentDatePicker.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/25.
//

import SwiftUI

struct CustomDatePicker<Content: View>: View {
    
    @Binding var date: Date
    var configration = PresentDatePicker.Configration()
    @ViewBuilder var content: () -> Content
    
    @State private var showPicker = false
    
    var body: some View {
        content()
            .onTapGesture {
                showPicker = true
            }
            .sheet(isPresented: $showPicker) {
                PresentDatePicker(date: $date, configration: configration)
            }
    }
    
}

/// 可以直接使用，也可以封装一下像系统datepicker一样模式；
struct PresentDatePicker: View {
    
    @Binding var date: Date
    var configration = Configration()
    
    var body: some View {
        AdaptionNavigationStack {
            VStack(spacing: 0) {
                Divider()
                makeDatePicker()
                .datePickerStyle(.graphical)
                Spacer()
                Divider()
            }
            .navigationTitle(configration.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .adaptionPresentationDetents([.height(520), .large]) // 模态修饰要放在最外边
    }
    
    @ViewBuilder func makeDatePicker() -> some View {
        switch configration.range {
        case .null:
            DatePicker(selection: $date, displayedComponents: configration.displayedComponents) {
                EmptyView()
            }
        case .from(let value):
            DatePicker(selection: $date, in: value, displayedComponents: configration.displayedComponents) {
                EmptyView()
            }
        case .to(let value):
            DatePicker(selection: $date, in: value, displayedComponents: configration.displayedComponents) {
                EmptyView()
            }
        case .closed(let value):
            DatePicker(selection: $date, in: value, displayedComponents: configration.displayedComponents) {
                EmptyView()
            }
        }
    }
    
    struct Configration {
        var title = "请选择时间"
        var minimumDate: Date?
        var maximumDate: Date?
        var displayedComponents: DatePickerComponents = [.hourAndMinute, .date]
        
        enum Range {
            case null
            case from(_ value: PartialRangeFrom<Date>)
            case to(_ value: PartialRangeThrough<Date>)
            case closed(_ value: ClosedRange<Date>)
        }
        var range: Range {
            if minimumDate == nil, maximumDate == nil {
                return .null
            }
            if let minimumDate {
                return .from(minimumDate...)
            }
            if let maximumDate {
                return .to(...maximumDate)
            }
            return .closed(minimumDate!...maximumDate!)
        }
    }
    
}
