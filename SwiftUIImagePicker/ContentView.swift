//
//  ContentView.swift
//  SwiftUIImagePicker
//
//  Created by Toomas Vahter on 21.11.2020.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            imageView(for: viewModel.selectedImage)
            controlBar()
        }
        .fullScreenCover(isPresented: $viewModel.isPresentingImagePicker, content: {
            ImagePicker(sourceType: viewModel.sourceType, completionHandler: viewModel.didSelectImage)
        })
    }
    
    @ViewBuilder
    func imageView(for image: UIImage?) -> some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        }
        else {
            Text("No image selected")
        }
    }
    
    func controlBar() -> some View {
        HStack(spacing: 32) {
            Button(action: viewModel.choosePhoto, label: {
                Text("Choose Photo")
            })
            Button(action: viewModel.takePhoto, label: {
                Text("Take a Photo")
            })
        }.padding()
    }
}

extension ContentView {
    final class ViewModel: ObservableObject {
        @Published var selectedImage: UIImage?
        @Published var isPresentingImagePicker = false
        private(set) var sourceType: ImagePicker.SourceType = .camera
        
        func choosePhoto() {
            sourceType = .photoLibrary
            isPresentingImagePicker = true
        }
        
        func takePhoto() {
            sourceType = .camera
            isPresentingImagePicker = true
        }
        
        func didSelectImage(_ image: UIImage?) {
            selectedImage = image
            isPresentingImagePicker = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
