//
//  NavigationStack.swift
//  bootstrap
//
//  Created by Thomas Allen on 2/19/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//

import Foundation
import SwiftUI

//- How to use:
//
// 1) Create the NavigationStack for the specific host
//
//    Ex - let stack = NavigationStack(NavigationItem( view: AnyView(RootView())))
//
//      Note... In each view added to the NavigationStack you will have to add
//          "@EnvironmentObject var navigation: NavigationStack" at the top of the struct declaration
//    Ex - struct root {
//            @EnvironmentObject var navigation: NavigationStack
//            var body: some View { }
//         }
//
//
// 2) Delcare the Navigation host as some view and include the corresponding
//    NavigationStack as an environment object
//
//    Ex - var host: some View { NavigationHost().environmentObject(stack) }
//
// 3) Utilize StackList if there are multiple stacks being tracked in the app at one time


//MARK: - NavigationHost
// pre-defined host view that acts as parent for views in Stack

struct NavigationHost: View {
    @EnvironmentObject var navigation: NavigationStack
    
    var body: some View {
        KeyboardOverlay {
            self.navigation.currentView.view
        }
    }
}


//MARK: - NavigationStack
// pre-defined stack to maintain view order and offers

final class NavigationStack: ObservableObject {
    //- Stack of previous visited and current views
    @Published var viewStack: [NavigationItem] = []
    
    //- alerts that there was a success to trigger alert/process
    @Published var successOnChild = false
    
    //- Current view being displayed
    @Published var currentView: NavigationItem
    
    //- Root view of navigation stack
    private var rootView: NavigationItem
    
    init(_ currentView: NavigationItem ){
        log.debug("NavigationStack: init with \(currentView.view)")
        self.rootView = currentView
        self.currentView = currentView
        self.viewStack = []
    }
    
    //- Removes view from navigation stack
    func pop() {
        if viewStack.count == 0 {
            log.debug("NavigationStack: pop NO ITEMS ON STACK")
            return
        }
        let last = viewStack.count - 1
        log.debug("NavigationStack: pop \(viewStack[last])")
        
        currentView = viewStack[last]
        viewStack.remove(at: last)
    }
    
    //- Adds view on nagication stack
    func push(_ view: NavigationItem) {
        log.debug("NavigationStack: push")
        viewStack.append(currentView)
        currentView = view
    }
    
    //- Returns to current stacks root view set at initialization
    func root( ){
        viewStack.removeAll()
        currentView = rootView
    }
}

//MARK: - NavigationItem
// smallest unit of navigation, removes view type and conforms to AnyView
struct NavigationItem {
    var view: AnyView
    
    init( view: AnyView) {
        self.view = view
    }
}


//MARK: - StackList
// TODO - update to make list
struct StackList {
    let homeStack: NavigationStack
}
