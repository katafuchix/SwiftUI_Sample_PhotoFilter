//
//  Views.swift
//  SwiftUI_Sample_PhotoFilter
//
//  Created by cano on 2022/01/01.
//

import SwiftUI

struct ThumbnailView: View {
    
    @EnvironmentObject var imageController: ImageController
    
    var width: CGFloat
    var height: CGFloat
    var filterName: String
    var filter: FilterType
    
    var body: some View {
        Button(action: {self.imageController.displayedImage = self.imageController.generateFilteredImage(inputImage: self.imageController.originalImage!, filter: self.filter)}) {
            VStack {
                Text(filterName)
                    .foregroundColor(.black)
                Image(uiImage: imageController.generateFilteredImage(inputImage: imageController.thumbnailImage!, filter: filter))
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .cornerRadius(20)
                    .clipped()
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
        }
    }
}


struct LeadingNavigationBarItems: View {
    
    @EnvironmentObject var imageController: ImageController
    
    @State var showImagePicker = false
    @State var showCameraView = false
    
    var body: some View {
        HStack {
            Button(action: {self.showImagePicker = true}) {
                Image(systemName: "photo")
                    .foregroundColor(Color(UIColor.black))
                    .imageScale(.large)
                }
                .sheet(isPresented: self.$showImagePicker) {
                    ImagePicker(imageController: self.imageController, showImagePicker: self.$showImagePicker)
                }
            
            Button(action: {self.showCameraView = true}) {
                Image(systemName: "camera")
                    .foregroundColor(Color(UIColor.black))
                    .imageScale(.large)
                }
                .sheet(isPresented: self.$showCameraView) {
                    CameraView(imageController: self.imageController, showCameraView: self.$showCameraView)
                }
        }
    }
}

struct TrailingNavigationBarItem: View {
    
    @EnvironmentObject var imageController: ImageController
    
    var body: some View {
        Button(action: {self.imageController.saveImage()}) {
            Image(systemName: "square.and.arrow.down")
                .foregroundColor(Color(UIColor.black))
                .imageScale(.large)
        }
    }
}

