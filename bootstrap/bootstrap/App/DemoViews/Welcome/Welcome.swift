//
//  Welcome.swift
//  bootstrap
//
//  Created by Thomas Allen on 2/28/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//

import SwiftUI

struct Welcome: View {
    @EnvironmentObject var state: AppState
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            welcomeText
            Spacer()
        }
        .frame(alignment: .center)
        .background(Color.white)
        .onTapGesture {
            self.state.currentView = .main
        }
    }
}

extension Welcome {
    
    var welcomeText: some View {
        VStack {
            Text("Welcome View")
                .welcomeHeaderStyle
                .padding(.bottom, 30)
            
            Text("Tap anywhere to navigate into the app")
                .welcomeCaptionStyle
        }
    }
}



struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
