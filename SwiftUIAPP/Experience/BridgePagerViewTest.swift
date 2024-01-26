//
//  BridgePagerViewTest.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/26.
//

import SwiftUI
import FSPagerView

struct BridgePagerViewTest: View {
    
    @State var imageList: [String] = ["height_01"]
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            Button("添加图片") {
                imageList = ["height_01", "height_02", "height_03", "height_04"]
            }
            
            PageView(imageList: $imageList)
                .aspectRatio(.init(width: 2, height: 1), contentMode: .fit)
                .background(.gray)
            
            Spacer()
            
            Divider()
        }
 
    }
    
    struct PageView: UIViewRepresentable {
        
        // MARK: - public
        
        @Binding var imageList: [String]
       
        // MARK: - life
        
        func makeCoordinator() -> Coordinator {
            Coordinator()
        }
        
        func makeUIView(context: Context) -> FSPagerView {
            context.coordinator.pageView
        }
        
        func updateUIView(_ uiView: FSPagerView, context: Context) {
            context.coordinator.imageList = imageList
        }
        
        class Coordinator: NSObject, FSPagerViewDataSource, FSPagerViewDelegate {
            
            lazy var pageView = {
                let view = FSPagerView()
                view.dataSource = self
                view.delegate = self
                view.isInfinite = true
                view.automaticSlidingInterval = 2
                view.interitemSpacing = 10
                view.itemSize = .zero
                
//                view.scrollDirection = .horizontal
//                view.transformer = FSPagerViewTransformer.init(type: .coverFlow)
                
                view.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
                return view
            }()
            
            var imageList: [String] = [] {
                didSet {
                    pageView.reloadData()
                }
            }
            
            func numberOfItems(in pagerView: FSPagerView) -> Int {
                imageList.count
            }
            
            func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
                let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
                cell.imageView?.image = UIImage(named: imageList[index])
                cell.imageView?.contentMode = .scaleAspectFill
                return cell
            }
            
        }
        
    }
    
}

#Preview {
    BridgePagerViewTest()
}
