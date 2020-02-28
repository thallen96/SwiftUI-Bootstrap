//
//  State.swift
//  bootstrap
//
//  Created by Thomas Allen on 2/28/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class AppState: ObservableObject {

    // Current view flow set
    @Published var currentView: SceneDelegate.SceneOptions = .welcome {
        didSet {
            if currentView != oldValue {
                SceneDelegate.current?.setScene(for: currentView)
            }
        }
    }

    //- Object of navigation stacks used in app
    // If you want to add more stacks first add them as vars in StackList object then
    // create NavigationStack with desired root view here
    @Published var stackList = {
        StackList(
            homeStack: NavigationStack(NavigationItem( view: AnyView(HomeView())))
        )
    }()

    
    //- Main Flow vars
    // Allows updating of which tab bar item to return to
    @Published var selected = 0
    
    //- Toggles full screen and hides base view if any
    @Published var showFullScreen: Bool = false
    
    //-  enum for overlay view displayed
    @Published var overlayView: OverlayEnum?
    
    //- Toggles sheet in current local view
    @Published var showLocalSheet: Bool = false
    
    //-  enum for sheet displayed
    @Published var shownSheet: SheetEnum?
    
    
    func close() {
        showFullScreen = false
        overlayView = nil
        showLocalSheet = false
        shownSheet = nil
    }
}

//- Full screen types
enum OverlayEnum {
    case swipe

}

//- Sheet types
enum SheetEnum {

}
