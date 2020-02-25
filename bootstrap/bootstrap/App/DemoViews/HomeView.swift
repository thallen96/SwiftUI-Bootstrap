//
//  HomeView.swift
//  bootstrap
//
//  Created by Elizabeth Johnston on 2/19/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var selected: Int? {
        didSet{
            print(_selected)
        }
    }
    
    var body: some View {
        ZStack{
            VStack{
                NavigationBarView(title: "Welcome to hell" , leftButton: NavButton.back(tapFunction: {}, color: nil), rightButton: NavButton.profilePic(imageURL: nil, caption: "Gary", tapFunction: {}), backgroundColor: nil, titleColor: nil)
                Spacer()
            }
            VStack{
                Spacer()
                // been using as workspace for testing components 
                Spacer()
            }
        }.edgesIgnoringSafeArea(.bottom)
            .background(Color.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
