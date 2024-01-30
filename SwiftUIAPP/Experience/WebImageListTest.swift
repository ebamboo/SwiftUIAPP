//
//  WebImageListTest.swift
//  SwiftUIAPP
//
//  Created by ebamboo on 2024/1/29.
//

import SwiftUI

/*
 xcode 运行 app 时，第一次进入该页面会有 1s 左右的延迟，这是调试环境才会出现的正常情况；
 */
struct WebImageListTest: View {
    
    let list = __web_image_test_image_list__
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        
                        ZStack {
                            Rectangle()
                                .fill(.clear)
                                .aspectRatio(.init(width: 4, height: 2), contentMode: .fill)
                            GeometryReader { geo in
                                AsyncImage(url: URL(string: "https://ziyou.kuama.tv/20230318/417502457540608.jpg")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        
                                } placeholder: {
                                    Color(uiColor: UIColor.systemGroupedBackground)
                                }
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipped()
                            }
                        }
                        .id("top")
                        
                        ForEach(0..<list.count, id: \.self) { index in
                            WebImageListTestCell(id: index, url: list[index])
                        }
                        
                        HStack {
                            Spacer()
                            Button {
                                withAnimation {
                                    proxy.scrollTo("top")
                                }
                            } label: {
                                Text("回到顶部")
                            }
                            Spacer()
                        }
                        .frame(height: 44)
                        
                    }
                }
                .padding(.horizontal, 8)
            }
            Divider()
        }
    }
    
}

struct WebImageListTestCell: View {
    
    let id: Int
    let url: URL?
    
    init(id: Int, url: String) {
        print("Loading row \(id)") // 注意观察 cell 创建时间；刚进入页面时，只会创建可看到 cell；滑动时会动态创建 cell；
        self.id = id
        self.url = URL(string: url)
    }
    
    var body: some View {
        HStack {
            
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(width: 100, height: 100)
            .clipped()
            
            VStack(alignment: .leading) {
                Text("主标题")
                Text("小标题")
                if id % 2 == 0 {
                    Text("计数变化")
                }
            }
            
        }
    }
    
}

#Preview {
    WebImageListTest()
}

private let __web_image_test_image_list__ = [
    "https://ziyou.kuama.tv/20230310/414547561463808.jpg",
    "https://ziyou.kuama.tv/20230805/467054776049664.jpg",
    "https://ziyou.kuama.tv/20230919/482844774387712.jpg",
    "https://ziyou.kuama.tv/20231114/502704083132416.jpg",
    "https://ziyou.kuama.tv/20230919/482844487213056.jpg",
    "https://ziyou.kuama.tv/20230812/469527695552512.jpg",
    "https://ziyou.kuama.tv/20230802/465966898520064.jpg",
    "https://ziyou.kuama.tv/20230807/467727097532416.jpg",
    "https://ziyou.kuama.tv/20230810/468822021009408.jpg",
    "https://ziyou.kuama.tv/20230318/417492601458688.png",
    "https://ziyou.kuama.tv/20231114/502704956510208.jpg",
    "https://ziyou.kuama.tv/20231016/492520485642240.jpg",
    "https://ziyou.kuama.tv/20230318/417457195184128.jpg",
    "https://ziyou.kuama.tv/20230819/472013044543488.jpg",
    "https://ziyou.kuama.tv/20230822/472941332283392.jpg",
    "https://ziyou.kuama.tv/20230823/473427331395584.jpg",
    "https://ziyou.kuama.tv/20230808/468114671534080.jpg",
    "https://ziyou.kuama.tv/20230804/466670978904064.jpg",
    "https://ziyou.kuama.tv/20230920/483213999263744.jpg",
    "https://ziyou.kuama.tv/20230909/479437810618368.jpg",
    "https://ziyou.kuama.tv/20230919/482844388028416.jpg",
    "https://ziyou.kuama.tv/20231114/502691419279360.jpg",
    "https://ziyou.kuama.tv/20230809/468415250198528.jpg",
    "https://ziyou.kuama.tv/20230801/465622114656256.jpg",
    "https://ziyou.kuama.tv/20230824/473641509875712.jpg",
    "https://ziyou.kuama.tv/20230802/465862565036032.jpg",
    "https://ziyou.kuama.tv/20230904/477672135557120.jpg",
    "https://ziyou.kuama.tv/20230811/469177435824128.jpg",
    "https://ziyou.kuama.tv/20230918/482627987980288.jpg",
    "https://ziyou.kuama.tv/20230804/466703357333504.jpg",
    "https://ziyou.kuama.tv/20231010/490373995995136.jpg",
    "https://ziyou.kuama.tv/20230814/470140779716608.jpg",
    "https://ziyou.kuama.tv/20230825/474013111160832.jpg",
    "https://ziyou.kuama.tv/20230804/466700047060992.jpg",
    "https://ziyou.kuama.tv/20230816/470940087795712.jpg",
    "https://ziyou.kuama.tv/20230812/469534401064960.jpg",
    "https://ziyou.kuama.tv/20230801/465630822789120.jpg",
    "https://ziyou.kuama.tv/20231114/502691597312000.jpg",
    "https://ziyou.kuama.tv/20231114/502704790044672.jpg",
    "https://ziyou.kuama.tv/20230807/467723878838272.jpg",
    "https://ziyou.kuama.tv/20230812/469527468843008.jpg",
    "https://ziyou.kuama.tv/20230901/476489445339136.jpg",
    "https://ziyou.kuama.tv/20230821/472721110593536.jpg",
    "https://ziyou.kuama.tv/20230919/482843466067968.jpg",
    "https://ziyou.kuama.tv/20231114/502705143197696.jpg",
    "https://ziyou.kuama.tv/20230919/482845278523392.jpg",
    "https://ziyou.kuama.tv/20230809/468413420359680.jpg",
    "https://ziyou.kuama.tv/20230318/417502457540608.jpg",
    "https://ziyou.kuama.tv/20231114/502710106411008.jpg",
    "https://ziyou.kuama.tv/20230919/482850892025856.jpg",
    "https://ziyou.kuama.tv/20230825/474015012098048.jpg",
    "https://ziyou.kuama.tv/20230816/470930887921664.jpg",
    "https://ziyou.kuama.tv/20231016/492521648967680.jpg",
    "https://ziyou.kuama.tv/20230920/483209728528384.jpg",
    "https://ziyou.kuama.tv/20230707/456855171637248.",
    "https://ziyou.kuama.tv/20230818/471520828129280.jpg",
    "https://ziyou.kuama.tv/20230804/466699436081152.jpg",
    "https://ziyou.kuama.tv/20230510/436225517453312.",
    "https://ziyou.kuama.tv/20231113/502416191275008.jpg",
    "https://ziyou.kuama.tv/20230805/467056551243776.jpg",
    "https://ziyou.kuama.tv/20230807/467725088342016.jpg",
    "https://ziyou.kuama.tv/20230808/468087902949376.jpg",
    "https://ziyou.kuama.tv/20230919/482850620096512.jpg",
    "https://ziyou.kuama.tv/20230801/465639127654400.jpg",
    "https://ziyou.kuama.tv/20231114/502691923767296.jpg",
    "https://ziyou.kuama.tv/20230801/465626926821376.jpg",
    "https://ziyou.kuama.tv/20231114/502692039249920.jpg",
    "https://ziyou.kuama.tv/20231117/503743276097536.jpg",
    "https://ziyou.kuama.tv/20230905/478028402950144.jpg",
    "https://ziyou.kuama.tv/20230811/469176258772992.jpg",
    "https://ziyou.kuama.tv/20230711/458065873973248.",
    "https://ziyou.kuama.tv/20230818/471525100871680.jpg",
    "https://ziyou.kuama.tv/20230817/471302318166016.jpg",
    "https://ziyou.kuama.tv/20230808/468082339389440.jpg",
    "https://ziyou.kuama.tv/20231012/491084015116288.jpg",
    "https://ziyou.kuama.tv/20230920/483204640223232.jpg",
    "https://ziyou.kuama.tv/20230815/470596256706560.jpg",
    "https://ziyou.kuama.tv/20230810/468820458328064.jpg",
    "https://ziyou.kuama.tv/20231225/517281193902080.jpg",
    "https://ziyou.kuama.tv/20230613/448196824858624.",
    "https://ziyou.kuama.tv/20230807/467729860562944.jpg",
    "https://ziyou.kuama.tv/20230909/479437530968064.jpg",
    "https://ziyou.kuama.tv/20231219/515156325867520.jpg",
    "https://ziyou.kuama.tv/20230818/471525927305216.jpg",
    "https://ziyou.kuama.tv/20230803/466293987364864.jpg",
    "https://ziyou.kuama.tv/20230427/431662270959616.",
    "https://ziyou.kuama.tv/20230323/419268271030272.jpg",
    "https://ziyou.kuama.tv/20230809/468416325259264.jpg",
    "https://ziyou.kuama.tv/20231114/502700787814400.jpg",
    "https://ziyou.kuama.tv/20230807/467725190017024.jpg"
]
