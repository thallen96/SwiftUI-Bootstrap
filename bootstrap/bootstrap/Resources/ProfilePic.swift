//
//  ProfilePic.swift
//  bootstrap
//
//  Created by Elizabeth Johnston on 2/20/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseUI
import SDWebImageSwiftUI


// TODO: Update this class to handle dynamic images
struct ProfilePicture: View {
    let color: Color
    let borderWidth: CGFloat
    let picURL: URL?
        
    var body: some View {
        WebImage(url: picURL)
            .onSuccess { image, cacheType in
                // Implement im memory caching when I have time
                print("ProfilePicture - image loaded.. \(String(describing: self.picURL))")
            }
            .homeStyle
            .overlay(
                Circle().stroke(self.color, lineWidth: self.borderWidth))
    }
}

// TODO: Update this class to handle dynamic images
struct SimplePictureGrey: View {
    // has "background" background color
    let url: URL?
        
    var body: some View {
        WebImage(url: url)
            .onSuccess { image, cacheType in
                // Implement im memory caching when I have time
                print("ProfilePicture - image loaded..")
            }
            .simpleGrey
    }
}

struct SimplePicture: View {
    // has no background color
    let url: URL?
        
    var body: some View {
        WebImage(url: url)
            .onSuccess { image, cacheType in
                // Implement im memory caching when I have time
                print("ProfilePicture - image loaded..")
            }
            .simple
    }
}

struct uploadedImage: View {
    let color: Color
    let borderWidth: CGFloat
    let image: UIImage?
    
    var body: some View {
        Image(uiImage: image ?? UIImage(systemName: "photo")!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
}

extension WebImage {
    
    var simpleGrey: some View {
        self
            .resizable()
            .placeholder {
                Image(systemName: "photo") // Placeholder
            }
            //.indicator(.activity) // Activity Indicator
            .background(Color.background)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
    
    var simple: some View {
        self
            .resizable()
            .placeholder {
                Image(systemName: "photo") // Placeholder
            }
            //.indicator(.activity) // Activity Indicator
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
    
    var homeStyle: some View {
        self
            .resizable()
            .placeholder {
                Image(General_Icons.profile_placeholder) // Placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .indicator(.activity) // Activity Indicator
            .background(Color.background)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
    
}

