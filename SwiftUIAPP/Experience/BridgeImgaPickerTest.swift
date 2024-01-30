//
//  BridgeImgaPickerTest.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI
import Photos

struct BridgeImgaPickerTest: View {
    
    @State var imageList: [(UIImage, PHAsset)] = []
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 8),
                    GridItem(.flexible(), spacing: 8),
                    GridItem(.flexible(), spacing: 8),
                ], 
                alignment: .leading,
                spacing: 8
            ) {
                
                ForEach(0..<imageList.count, id: \.self) { index in
                    ZStack {
                        Rectangle()
                            .fill(.clear)
                            .aspectRatio(.init(width: 1, height: 1), contentMode: .fill)
                        
                        GeometryReader { geo in
                            Image(uiImage: imageList[index].0)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
                        }
                        .clipped()
                    }
                }
                var configration = ImagePickerPage.Configration()
                let _ = configration.maxImagesCount = 4
                if imageList.count < 4 {
                    CustomImagePicker(configration: configration,
                                      selectedAssets: Binding<[PHAsset]>(
                                        get: { imageList.map({ $0.1 }) },
                                        set: { _ in }
                                      )) {
                        Image(systemName: "plus.viewfinder")
                            .resizable()
                            .aspectRatio(.init(width: 1, height: 1), contentMode: .fill)
                    } completion: { infoList in
                        imageList = infoList
                    }
                }
                
            }
            .background(.gray)
            
            
        }
        .padding()
    }
    
    
    
}

#Preview {
    BridgeImgaPickerTest()
}
