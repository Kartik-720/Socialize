//
//  UploadPostView.swift
//  Socialize
//
//  Created by Kartik Sharma on 25/08/24.
//

import SwiftUI
import PhotosUI
struct UploadPostView: View {
    @State private var caption = ""
    @State private var isImagePresented = false
    @StateObject private var viewModel=UploadPostViewModel()
    @Binding var tabIndex : Int
    var body: some View {
        VStack{
            HStack{
                Button{
                    caption = ""
                    viewModel.selectedImage=nil
                    viewModel.postImage=nil
                    tabIndex = 0
                }
            label: {
                    Text("Cancel")
                }
                Spacer()
                Text("New Post")
                Spacer()
                Button{
                    print("Upload")
                }
            label: {
                    Text("Upload")
                }
            }
            .padding(.horizontal)
            VStack{
                if let image = viewModel.postImage{
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 400,height: 400)
                        .clipped()
                }
            }
            TextField("Write a caption", text: $caption,axis: .vertical)
                .padding(.horizontal)
                .padding(.vertical)
            Spacer()
        }
        .onAppear{
            isImagePresented.toggle()
        }
        .photosPicker(isPresented: $isImagePresented, selection: $viewModel.selectedImage)
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0))
}
