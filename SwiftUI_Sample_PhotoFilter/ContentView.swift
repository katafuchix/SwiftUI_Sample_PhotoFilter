//
//  ContentView.swift
//  SwiftUI_Sample_PhotoFilter
//
//  Created by cano on 2022/01/01.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var imageController: ImageController
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Image(uiImage: self.imageController.displayedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height*(3/4))
                        .clipped()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ThumbnailView(width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "Original", filter: .Original)
                            ThumbnailView(width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "Sepia", filter: .Sepia)
                            ThumbnailView(width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "Mono", filter: .Mono)
                            ThumbnailView(width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "Vibrance", filter: .Vibrance)
                            ThumbnailView(width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "Highlight", filter: .Highlight)
                            ThumbnailView(width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "Vignette", filter: .Vignette)
                        }
                    }
                        .frame(width: geometry.size.width, height: geometry.size.height*(1/4))
                }
            }
                .navigationBarTitle("Filter App", displayMode: .inline)
                .navigationBarItems(leading: LeadingNavigationBarItems(), trailing: TrailingNavigationBarItem())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ImageController())
    }
}
