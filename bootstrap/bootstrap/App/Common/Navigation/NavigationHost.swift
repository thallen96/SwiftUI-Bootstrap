//
//  NavigationHost.swift
//  bootstrap
//
//  Created by Thomas Allen on 2/19/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//

import Foundation
import SwiftUI

struct NavigationHost: View {
   @EnvironmentObject var navigation: NavigationStack
   
   var body: some View {
      self.navigation.currentView.view
   }
}
