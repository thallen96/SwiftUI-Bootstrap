//
//  ProfilePic.swift
//  bootstrap
//
//  Created by Elizabeth Johnston on 2/20/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//
// - Custom image styles and declarations ideal for uploading and displaying profile pictures
/// Though they are designed for the purpose of profile pictures, they are examples for custom image style declarations and image extension declarations

import SwiftUI
import SDWebImageSwiftUI


//MARK: - PROFILE IMAGES
// pre-defined, reusable image formats to quickly render

struct ProfilePicture: View {
    //- dispalys a WebImage in a cropped circle with a custom colored border and .homeStyle styling
    let borderColor: Color
    let borderWidth: CGFloat
    let imageURL: URL?
        
    var body: some View {
        WebImage(url: imageURL)
            .onSuccess { image, cacheType in
                print("ProfilePicture - image loaded.. \(String(describing: self.imageURL))")
            }
            .homeStyle
            .overlay(
                Circle().stroke(self.borderColor, lineWidth: self.borderWidth)
            )
    }
}

struct SimplePicture: View {
    //- displays a web image with .simple styling
    let imageURL: URL?
    
    var body: some View {
        WebImage(url: imageURL)
            .onSuccess { image, cacheType in
                print("SimplePicture - image loaded.. \(String(describing: self.imageURL))")
            }
            .simple
    }
}

struct UploadedImage: View {
    //- dispalys a UIImage in a cropped circle with a custom colored border, default system "photo" if image is nil, white background color if nil
    /// ideal for displaying an image selected from photos
    let borderColor: Color
    let borderWidth: CGFloat
    let backgroundColor: Color?
    let image: UIImage?
    
    var body: some View {
        Image(uiImage: image ?? UIImage(systemName: "photo")!)
            .simple
            .background(backgroundColor ?? Color.white)
            .overlay(
                Circle().stroke(self.borderColor, lineWidth: self.borderWidth))
    }
}


//MARK: - WEBIMAGE EXTENSIONS
// pre-defined styles to quickly apply to WebImages

extension WebImage {
    
    var simple: some View {
        self
            .resizable()
            .placeholder {
                Image(systemName: "photo") // Placeholder
            }
            .background(Color.gray)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
    
    var homeStyle: some View {
        self
            .resizable()
            .placeholder {
                Image(systemName: SFSymbols.person)
                    .foregroundColor(Color.white)
            }
            .indicator(.activity)           ///**TIP** .inidicator is best defined after frame size is defined but is here to conform to dynamic size.
            .background(Color.gray)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
    
}

//MARK: - IMAGE EXTENSIONS
// pre-defined styles to quickly apply to Images

extension Image {
    
    var simple: some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
}

