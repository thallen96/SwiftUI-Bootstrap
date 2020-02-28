//
//  Main.swift
//  bootstrap
//
//  Created by Thomas Allen on 2/28/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//

import SwiftUI

struct Main: View {
    @EnvironmentObject var state: AppState
    
    @State var selected: VolumeButton.VolumeLevel = VolumeButton.VolumeLevel.high
    @State var power: Bool = false
    
    init () {
        //- Setting TabView appearance
        UITabBar.appearance().barTintColor = UIColor.systemBlue
        UITabBar.appearance().unselectedItemTintColor = UIColor.systemGray
        UITabBar.appearance().frame.size.height = 95
    }
    
    var body: some View {
        ZStack{
            TabView(selection: $state.selected) {
                home.tabItem {
                    $state.selected.wrappedValue == 0 ? Image(systemName: "house") : Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
                
                
                //                playerItem.tabItem {
                //                    $dashboardExtension.selected.wrappedValue == 2 ? Image(TabBarImageName.student_active) : Image(TabBarImageName.student_blue)
                //                    Text(TabBarImageText.student)
                //                }.tag(1)
                
                
                
            }
            .accentColor(Color.white)
            
            //- If true tab bar is hidden and view are full screen
            if $state.showFullScreen.wrappedValue {
                viewBuilder
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.bottom)
                    .transition(.move(edge: .bottom))
            }
        }
        .background(Color.white)
    }
}

extension Main {
    
    // MARK: TabItem Init for homeItem
    var home: some View {
        NavigationHost()
            .environmentObject(self.state.stackList.homeStack)
    }
    
    // MARK: Creates full screen view
    //- based on state.overlayView var
    var viewBuilder: AnyView? {
        guard let overlay = state.overlayView else {
            log.error("State - main: no overlayView set")
            return nil
        }
        
        //- if new view needed, add case and AnyView object below
        switch overlay {
            // commented until we can build out the swipe view but leaving as reference
            //        case .swipe:
        //            return nil
        default:
            return nil
        }
    }
    
    //    //- Swipe overlay
    // commented until we can build out the swipe view but leaving as reference
    //    var swipe: AnyView {
    //        return AnyView(Swipe())
    //    }
}



struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
