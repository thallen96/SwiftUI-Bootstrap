//
//  SelectRangeDateCalendar.swift
//  bootstrap
//
//  Created by Elizabeth Johnston on 2/26/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//
// - A full month calendar view that allows you change months and select a two dates as the start and end dates of a range
//


import SwiftUI

struct SelectRangeCalendarDate: View {
    
    @State private var daysMap = [Int](repeating: 0, count: 42)
    
    @Binding var startDateSelected: Date?
    @Binding var endDateSelected: Date?
    @State private var dateShown: Date = Date()
    @State private var firstSelection: Bool = true    ///used to keep track of if user's first selection and second
    
    //Styling variables
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

extension SelectRangeCalendarDate {
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

extension SelectRangeCalendarDate {
    
    //MARK: PUBLIC FUNCTIONS
    
    
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
        //- return the stylized Text for the given date
        
        let formatter = DateFormatter()
        // if it is the selected day, it will return with different styling
        if (String(date) == self.startDateSelected?.dayOfMonthMedium && self.startDateSelected?.monthMedium == self.dateShown.monthMedium && self.startDateSelected?.yearMedium == self.dateShown.yearMedium) || (String(date) == self.endDateSelected?.dayOfMonthMedium && self.endDateSelected?.monthMedium == self.dateShown.monthMedium && self.endDateSelected?.yearMedium == self.dateShown.yearMedium) {
            /// check if the date is the start or end date
            return  AnyView(
                        Text(String(date))
                            .scaledFont(name: Avenir_Fonts.heavy, size: 14)
                            .foregroundColor(self.accentColor)
                            .frame(width: 30, height: 30)
                            .background(self.primaryColor)
                            .clipShape(Circle())
                            .onTapGesture {
                                if date != 0 {
                                    self.setSelectedDate(date: date)
                                }
                            }
                    )
        } else if formatter.dateBetweenChecker(startDate: self.startDateSelected, endDate: self.endDateSelected, checkDate: Formatter.dateMedium.date(from: "\(self.dateShown.monthMedium) \(String(date)), \(self.dateShown.yearMedium)")) {
            /// check if the date is between the start or end date
            return  AnyView(
                       Text(String(date))
                            .scaledFont(name: Avenir_Fonts.heavy, size: 14)
                            .foregroundColor(Color.gray)
                            .frame(width: 30, height: 30)
                        .background(self.primaryColor.opacity(0.3))
                            .clipShape(Circle())
                            .onTapGesture {
                                if date != 0 {
                                    self.setSelectedDate(date: date)
                                }
                            }
                    )
        
        } else {
            return AnyView(
                Text(date == 0 ? " " : String(date))
                    .scaledFont(name: Avenir_Fonts.light, size: 15)
                    .foregroundColor(Color.gray)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        if date != 0 {
                            self.setSelectedDate(date: date)
                        }
                    }
                    )
        }
        
    }
    
    
    
    func setSelectedDate(date: Int){
        //- format and set the selected date
        
        //use the month and year from date shown along with the selected date to create the selected Date object
        let newDateString = "\(self.dateShown.monthMedium) \(String(date)), \(self.dateShown.yearMedium) "
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        if let newDate = formatter.date(from: newDateString){
            //check which date (start or end) to assign to
            if self.firstSelection {
                //if its the first selection, start date
                self.startDateSelected = newDate
                self.endDateSelected = nil ///resets the end date if re-selecting
            } else if self.startDateSelected ?? newDate > newDate { ///should never default to newDate but if it does it will be false
                //if its the second selection but the date is before the start date, set start date as end and new date as start
                self.endDateSelected = self.startDateSelected
                self.startDateSelected = newDate
            } else {
                //if its the second selection and after the start date, end date
                self.endDateSelected = newDate
            }
        }
        
        //update that a selection has been made
        self.firstSelection.toggle()
        
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

        if let firstOfMonthDate = Formatter.dateMedium.date(from: firstOfMonthString){
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
