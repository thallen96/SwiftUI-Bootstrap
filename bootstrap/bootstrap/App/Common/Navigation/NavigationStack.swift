//
//  NavigationStack.swift
//  bootstrap
//
//  Created by Thomas Allen on 2/19/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//

import Foundation
import SwiftUI

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
        if viewStack.count == 0{
            log.debug("NavigationStack: pop NO ITEMS ON STACK")
            return }
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
    
    //- Returns to the dashboard home view
    func home(){
        viewStack.removeAll()
//        currentView = NavigationItem( view: AnyView(HomeView(environmentObject)))
        currentView = NavigationItem( view: AnyView(HomeView()))
    }
    
    //- returns to current stacks root view
    func root( ){
        currentView = rootView
        viewStack = []
    }
}

struct NavigationItem{
    var view: AnyView
    
    init( view: AnyView) {
        log.debug("NavigationItem: init with \(view.self)")
        self.view = view
    }
}
