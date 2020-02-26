//
//  SceneTransitionButtons.swift
//  bootstrap
//
//  Created by Thomas Allen on 10/2/19.
//  Copyright © 2019 CapTech Consulting. All rights reserved.
//
// - Buttons with the purpose of transitioning to predefined scene when tapped.

import SwiftUI

//TODO: Thomas, was this ever used in the project? It seems all cancel buttons were declared in their view along with the other buttons that have this same 'transition' 'scene' setup. 
//struct CancelButton: View {
//    let transition: (_ scene: SceneDelegate.SceneOptions) -> Void
//    let scene: SceneDelegate.SceneOptions
//    
//    var body: some View {
//        Button(action: {
//            self.transition(self.scene)
//                }) {
//                    Text("Cancel")
//                }
//                .padding()
//                .font(.headline)
//                .foregroundColor(.darkBlue)
//                .frame(width: 250, height: 50)
//                .background(Color.white)
//                .addBorder(Color.darkBlue, width: 1, cornerRadius: 10)
//                .padding(.bottom, 10)
//    }
//}
