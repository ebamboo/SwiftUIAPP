//
//  ImagePickerPage.swift
//  SwiftUIAPP
//
//  Created by 姚旭 on 2024/1/25.
//

import SwiftUI
import TZImagePickerController

struct CustomImagePicker<Content: View>: View {
    
    var configration = ImagePickerPage.Configration()
    @Binding var selectedAssets: [PHAsset]
    @ViewBuilder var content: () -> Content
    let completion: ([(UIImage, PHAsset)]) -> Void
    
    @State private var showPicker = false
    
    var body: some View {
        content()
            .onTapGesture {
                showPicker = true
            }
            .sheet(isPresented: $showPicker) {
                ImagePickerPage(configration: configration, selectedAssets: $selectedAssets, completion: completion)
            }
    }
    
}

struct ImagePickerPage: UIViewControllerRepresentable {
    
    var configration = Configration()
    @Binding var selectedAssets: [PHAsset]
    let completion: ([(UIImage, PHAsset)]) -> Void

    func makeUIViewController(context: Context) -> TZImagePickerController {
        let picker = TZImagePickerController(maxImagesCount: configration.maxImagesCount, columnNumber: configration.columnNumber, delegate: nil)!
        picker.allowPickingVideo = false
        picker.allowTakeVideo = false
        picker.allowPickingGif = false
        picker.showPhotoCannotSelectLayer = configration.showPhotoCannotSelectLayer
        picker.showSelectedIndex = configration.showSelectedIndex
        picker.didFinishPickingPhotosHandle = { images, assets, isOriginal in
            guard let images = images, !images.isEmpty,
                  let assets = assets, !assets.isEmpty,
                  images.count == assets.count else {
                completion([])
                return
            }
            let infoList = (0..<images.count).map { index in
                (images[index], assets[index] as! PHAsset)
            }
            completion(infoList)
        }
        return picker
    }
    
    func updateUIViewController(_ uiViewController: TZImagePickerController, context: Context) {
        uiViewController.selectedAssets = NSMutableArray(array: selectedAssets)
    }
    
    struct Configration {
        var maxImagesCount = 9 // 等于 1 表示单选模式
        var columnNumber = 4
        var showPhotoCannotSelectLayer = true // 超过最大限制其他图片添加蒙版不可选
        var showSelectedIndex = true // 显示序号
    }
    
}
