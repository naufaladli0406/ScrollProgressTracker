//
//  ContentView.swift
//  ScrollProgressTracker
//
//  Created by Naufal Adli on 02/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var scrollOffSet: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    var body: some View {
        ScrollViewReader(content: { scrollproxy in
            GeometryReader(content: { fullview in
                ZStack(alignment: .top){
                    ScrollView{
                        //3
                        GeometryReader(content: { ScrollViewGeo in
                            Color.clear.preference(key: ScrollOffSetKey.self, value:ScrollViewGeo.frame(in: .global).minY)
                        }).frame(height: 0).tag(0)
                        VStack{
                            Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.")
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        //2
                        .background(GeometryReader{ contentGeo in
                            Color.clear.preference(key: ContentHeightPreferenceKey.self, value: contentGeo.size.height)
                        })
                    }
                    .onPreferenceChange(ScrollOffSetKey.self){
                        self.scrollOffSet = $0 - fullview.safeAreaInsets.top
                        
                    }
                    .onPreferenceChange(ContentHeightPreferenceKey.self){
                        self.contentHeight = $0 - fullview.safeAreaInsets.top
                        
                    }
                    progreeView(fullView: fullview, ScrollProxy: scrollproxy)
                      
                }
            })
        })
    }
    
    func progreeView(fullView: GeometryProxy, ScrollProxy: ScrollViewProxy) -> some View{
        let progress = min(max(0, -scrollOffSet / (contentHeight - fullView.size.height)), 1)
        let progressPercentage = Int(progress * 100)
        return ZStack{
     
            Group{
                ZStack(alignment: .leading){
                    if progressPercentage == 100 {
                        
                    } else {
                        RoundedRectangle(cornerRadius: 40)
                            .frame(width: 250,height: 55)
                            .foregroundColor(.white)
                    }
                    
                    HStack{
                        Text("\(progressPercentage)%").bold()
                        RoundedRectangle(cornerRadius: 20).foregroundStyle(.red)
                            .frame(width: 150 * progress,height: 8)
                    }
                    .padding(.leading,20)
                    .opacity(progressPercentage > 0 && progressPercentage < 100 ? 0.8 : 0)
                    .animation(.easeInOut, value: progressPercentage)
                }
            }
            .opacity(progressPercentage > 0 ? 0.8 : 0)
            
        }.mask{
            RoundedRectangle(cornerRadius: 40)
                .frame(width: progressPercentage > 0 && progressPercentage < 100 ? 250 : 55, height: 55)
                .animation(.easeInOut, value: progressPercentage)
        }
        .frame(maxHeight: .infinity,alignment: .bottom)
    }
}

struct ContentHeightPreferenceKey: PreferenceKey{
    static var defaultValue:CGFloat = 0
    static func reduce (value: inout CGFloat, nextValue newValue : () -> CGFloat){
        value = max(value, newValue())
    }
}

struct ScrollOffSetKey: PreferenceKey{
    static var defaultValue:CGFloat = 0
    static func reduce (value: inout CGFloat, nextValue newValue : () -> CGFloat){
        value = newValue()
    }
}

#Preview {
    ContentView()
}
