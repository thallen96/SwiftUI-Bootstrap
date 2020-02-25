//
//  ImagePicker.swift
//  bootstrap
//
//  Created by Thomas Allen on 11/19/19.
//  Copyright © 2019 CapTech Consulting. All rights reserved.
//
//- Allows the user to pick an image from their picture library and upload to the application
/// this is based on UIKit and is formated to work in SwiftUI by using UIVIewControllerRepresentable protocal
//

import Foundation
import SwiftUI
import Combine

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presentationMode: PresentationMode
        @Binding var image: UIImage?

        init(presentationMode: Binding<PresentationMode>, image: Binding<UIImage?>) {
            _presentationMode = presentationMode
            _image = image
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[.editedImage] as! UIImage    ///**TIP** different versions of the photo can be uploaded by changing .editedImage to selected image type
            image = uiImage
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true             ///**TIP** This allows to user to adjust image to frame size before uploading. To disable, set to false and change info[.editedImage] in imagePickerController funct to info[.originalImage]
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}

