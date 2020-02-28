//
//  Style+extensions.swift
//  bootstrap
//
//  Created by Thomas Allen on 2/19/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//
// - Custom styles for common elements
/// Shown are examples, but the purpose of this type of document is consistent designs and styles throughout the application.
//

import Foundation
import SwiftUI


//MARK: - BUTTONS

extension Button {
    // custom styles applicable to a button element

    
    // - Examples of primary, secondary and disabled primary style buttons of set frame.
    
    var primaryStyle : some View {
        self
            .padding(10)
            .font(.custom(Avenir_Fonts.medium, size: 17))
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(3)
            .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
    }
    
    var secondaryStyle : some View {
        self
            .padding(.vertical, 12)
            .frame(width: 337, height: 34)
            .font(.custom(Avenir_Fonts.medium, size: 17))
            .foregroundColor(.blue)
            .background(Color.white)
            .addBorder(Color.blue, width: 1, cornerRadius: 3)       /// custom border function found in Extensions.swift file
            .cornerRadius(3)
            .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
    }
    
    var disabledPrimaryStyle : some View {
        self
            .padding(.vertical, 12)
            .frame(width: 337, height: 34)
            .font(.custom(Avenir_Fonts.medium, size: 17))
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(3)
            .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
            .disabled(true)
    }
    
    
    
    // - Example of flexible width button
    
    var disabledFlexWidthPrimaryStyle : some View {
        // Since width is not defined, button width will be based on label view width.
        /// ** TIP ** to be max width of parent view, Text() in button declaration must be placed between two spacers in an HStack
        self
            .frame(height: 34)
            .font(.custom(Avenir_Fonts.medium, size: 17))
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(3)
            .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
    }

}


//MARK: - TEXT

extension Text {
    // custom styles applicable to a button element
    
    // - Example of basic font styling
    
    var primaryHeaderStyle: some View {
        self
            .font(.custom(Avenir_Fonts.heavy, size: 16))
            .foregroundColor(Color.blue)
    }
    
    var caption: some View {
        self
            .font(.custom(Avenir_Fonts.heavy, size: 10))
            .foregroundColor(Color.gray)
    }
    
    //- Example of basic welcome screen styles
    var welcomeHeaderStyle: some View {
        self
            .font(.custom(Avenir_Fonts.heavy, size: 20))
            .foregroundColor(Color.gray)
    }
    
    var welcomeCaptionStyle: some View {
        self
            .font(.custom(Avenir_Fonts.heavy, size: 15))
            .foregroundColor(Color.gray)
    }
    
    
    // - Example of additional Text element styling

    var fakeButtonStylePrimary: some View {
        self
            .padding(.vertical, 17)
            .font(.custom(Avenir_Fonts.heavy, size: 18))
            .foregroundColor(.white)
            .frame(width: 234, height: 46)
            .background(Color.blue)
            .cornerRadius(3)
            .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
            .padding(.bottom, 10)
    }

    
}
