//
//  HomeView.swift
//  bootstrap
//
//  Created by Elizabeth Johnston on 2/19/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var selected: VolumeButton.VolumeLevel = VolumeButton.VolumeLevel.high
    
    @State var events: [Date] = [Date]()
    
    @State var power: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                NavigationBarView(title: "Welcome to hell" , leftButton: NavButton.back(tapFunction: {}, color: nil), rightButton: NavButton.profilePic(imageURL: nil, caption: "Gary", tapFunction: {}), backgroundColor: nil, titleColor: nil)
                Spacer()
            }
            VStack{
                Spacer()
                // been using as workspace for testing components
                HeatMapCalendar(events: $events, heatColor: Color.blue)
                Spacer()
            }
        }.edgesIgnoringSafeArea(.bottom)
            .background(Color.white)
        .onAppear{
            self.addFakeEvents()
        }
    }
}

extension HomeView{
    
    func addFakeEvents() {
        var tempEvents = [Date]()
        
        for day in 1...28 {
            for _ in 0...Int.random(in: 0...6){
                tempEvents.append(Formatter.dateShort.date(from: "02/\(String(day))/2020") ?? Date())
            }
        }
        tempEvents.append(Formatter.dateShort.date(from: "03/3/2020") ?? Date())
        tempEvents.append(Formatter.dateShort.date(from: "03/3/2020") ?? Date())
        tempEvents.append(Formatter.dateShort.date(from: "03/4/2020") ?? Date())

        self.events = tempEvents
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
