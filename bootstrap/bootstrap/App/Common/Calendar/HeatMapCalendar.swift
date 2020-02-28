//
//  HeatMapCalendar.swift
//  bootstrap
//
//  Created by Elizabeth Johnston on 2/5/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//
// - A full month calendar view that acts as a heatmap and darkens on days it has more events
//
/// This is ideal for a quick reference of how busy a schedule
/// this is assuming a "full" day (the darkest color) is at least 5 events

import SwiftUI

struct HeatMapCalendar: View {
    
    @State private var daysMap = [Int](repeating: 0, count: 42)
    @State private var dateShown: Date = Date()

    @Binding var events: [Date]         /// set as binding to update more regularly but easily changable to static 
    
    
    //Styling variables
    var heatColor: Color = Color.blue
    var primaryColor: Color = Color.blue
    var accentColor: Color = Color.white
        
    var body: some View {
        VStack(spacing:0){
            
            //-- Month and year
            HStack{
                Image(systemName: SFSymbols.chevron_left)
                    .foregroundColor(self.primaryColor)
                    .frame(width: 13, height: 14)
                    .onTapGesture {
                        self.previousMonth()
                    }
                Spacer()
                Text("\(self.dateShown.monthMedium.uppercased()) \(self.dateShown.yearMedium)")
                    .font(.custom(Avenir_Fonts.heavy, size: 16))
                    .foregroundColor(self.primaryColor)
                Spacer()
                Image(systemName: SFSymbols.chevron_right)
                    .foregroundColor(self.primaryColor)
                    .frame(width: 13, height: 14)
                    .onTapGesture {
                        self.nextMonth()
                    }
            }.frame(height:45)
            
            Group{
                daysOfWeekTitle
                
                calendarDaysViews
            }.cornerRadius(2.0)
            .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
            
            }
            .onAppear{
                self.setDaysMap()
        }
    }
    
}

extension HeatMapCalendar {
    var daysOfWeekTitle: some View {
        //- Days of week title strip
        HStack(spacing:0){
            Group{  //had to split to two groups because of swiftui 10+ view rule
               Spacer()
                Text("S").font(.custom(Avenir_Fonts.heavy, size: 16)).foregroundColor(self.accentColor).frame(width: 20)
               Spacer()
               Text("M").font(.custom(Avenir_Fonts.heavy, size: 16)).foregroundColor(self.accentColor).frame(width: 20)
               Spacer()
               Text("T").font(.custom(Avenir_Fonts.heavy, size: 16)).foregroundColor(self.accentColor).frame(width: 20)
            }
            Group{
               Spacer()
               Text("W").font(.custom(Avenir_Fonts.heavy, size: 16)).foregroundColor(self.accentColor).frame(width: 20)
               Spacer()
               Text("T").font(.custom(Avenir_Fonts.heavy, size: 16)).foregroundColor(self.accentColor).frame(width: 20)
               Spacer()
               Text("F").font(.custom(Avenir_Fonts.heavy, size: 16)).foregroundColor(self.accentColor).frame(width: 20)
               Spacer()
               Text("S").font(.custom(Avenir_Fonts.heavy, size: 16)).foregroundColor(self.accentColor).frame(width: 20)
               Spacer()
            }
        }.frame(height:38).background(self.primaryColor)
    }
        
        
    var calendarDaysViews: some View {
        //- fills out proper value for each day spot in the calendar (even blank spots)
        VStack(spacing: 0){
            ForEach(0..<6, id: \.self) { j in   /// For each week in the calendar
                HStack(spacing: 0){
                    Spacer()
                    ForEach(0..<7, id: \.self) { i in   ///For each day in that week
                        Group{
                            self.getDateView(date: self.daysMap[i+(j*7)])   /// had to make a formula for this instead of a view because complexity broke xcode
                            Spacer()
                        }
                    }
                }.frame(height:38)
            }
        }.background(Color.white)
    }
    
}

//MARK: - FUNCTIONS

extension HeatMapCalendar {
    
    //MARK: FUNCTIONAL FUNCTIONS
    
    func previousMonth() {
        //- update to previous month
        
        // removes one month from the date shown
        self.dateShown = Calendar.current.date(byAdding: .month, value: -1, to: self.dateShown) ?? Date()
        
        // updates the days order on the map to the new month
        self.setDaysMap()
    }
    
    
    func nextMonth() {
        //- update to next month
        
        // adds one month from the date shown
        self.dateShown = Calendar.current.date(byAdding: .month, value: 1, to: self.dateShown) ?? Date()
        
        // updates the days order on the map to the new month
        self.setDaysMap()
    }
    
    
    
    func getDateView(date: Int) -> AnyView {
        //- return the text view of the given day
        
        //convert the date value into a Date object
        guard let fullDate = Formatter.dateMedium.date(from: "\(self.dateShown.monthMedium) \(String(date)), \(self.dateShown.yearMedium)") else {
            //should never fail for actual dates (only the 0's) but if it does, return the plain Text view
            return AnyView(
                Text(date == 0 ? " " : String(date))
                   .scaledFont(name: Avenir_Fonts.medium, size: 14)
                   .foregroundColor(Color.gray)
                   .frame(width: 30, height: 30)
                   .clipShape(Circle())
                )
        }
        
        if self.events.filter({$0.dateMedium == fullDate.dateMedium}).count == 0 {
            return AnyView(
                Text(date == 0 ? " " : String(date))
                    .scaledFont(name: Avenir_Fonts.medium, size: 14)
                    .foregroundColor(Color.gray)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            )
        } else {
            return  AnyView(
                Text(String(date))
                    .scaledFont(name: Avenir_Fonts.heavy, size: 14)
                    .shadow(color: Color.gray, radius: 0.8)
                    .foregroundColor(self.accentColor)
                    .frame(width: 30, height: 30)
                    .background(self.heatColor.opacity((Double(self.events.filter({$0.dateMedium == fullDate.dateMedium}).count) * 0.2)))    /// filters events using only the date (dateMedium) and multiplies that count by .2 (so at 5 events, opacity will reach its max)
                    .clipShape(Circle())
            )
        }
        
    }
    
    
    
    func setDaysMap() {
        //- set up array to include before and after filler days and proper number of days
        /// NOTE: filler days are set as zero
        
        let dow = ["sunday","monday","tuesday","wednesday","thursday","friday","saturday"]      /// used to determine how many days to add before 1st day of month in array
        self.daysMap = [Int]()
        
        // add proper number of days based on month
        if self.dateShown.monthMediumShortened.lowercased() == "sep" || self.dateShown.monthMediumShortened.lowercased() == "apr" || self.dateShown.monthMediumShortened.lowercased() == "jun" || self.dateShown.monthMediumShortened.lowercased() == "nov" {
            self.daysMap = Array(1...30)
        } else if self.dateShown.monthMediumShortened.lowercased() == "feb" {
            //check if it's a leap year or not
            if (Int(self.dateShown.yearMedium) ?? 0) % 4 != 0 {
                //if not leap year
                self.daysMap = Array(1...28)
            } else {
                //if leap year
                self.daysMap = Array(1...29)
            }
        } else {
            self.daysMap = Array(1...31)
        }
        
        // determine what day of week month starts on
        let firstOfMonthString = "\(self.dateShown.monthMedium) 1, \(self.dateShown.yearMedium) "
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        if let firstOfMonthDate = formatter.date(from: firstOfMonthString){
            // add filler days to beginning of month array
            let filler = [Int](repeating: 0, count: (dow.firstIndex(of: firstOfMonthDate.weekdayMedium.lowercased()) ?? 0))
            self.daysMap = filler + self.daysMap
        }
        
        // fill end of array with filler
        for _ in 0...(42-self.daysMap.count){
            self.daysMap.append(0)
        }
        
    }
}
