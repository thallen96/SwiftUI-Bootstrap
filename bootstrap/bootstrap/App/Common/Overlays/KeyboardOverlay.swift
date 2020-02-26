//
//  KeyboardOverlay.swift
//  bootstrap
//
//  Created by Thomas Allen on 2/26/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//

import Foundation
import SwiftUI

//MARK: - KeyboardOverlay
// clear view that dismisses the keyboard when tapped

struct KeyboardOverlay<Content>: View where Content: View  {
    var content: () -> Content
    
    var body: some View {
        Color.clear
            .overlay(content().padding(0))
            .onTapGesture {
                UIApplication.shared.endEditing()
        }
    }
}
