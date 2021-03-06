//
//  Extensions.swift
//  bootstrap
//
//  Created by Thomas Allen on 10/2/19.
//  Copyright © 2019 CapTech Consulting. All rights reserved.
//
// - extensions for various elements

import Foundation
import SwiftUI
import Combine
import UIKit
import Promises


// MARK: - DATE EXTENSIONS

extension Date {
    ///note: certain extensions used on Formatter are custom as well
    
    //- shortened way of returing various elements of date value
    
    var monthMediumShortened: String  { return Formatter.monthMediumShortened.string(from: self) }
    
    var monthMedium: String  { return Formatter.monthMedium.string(from: self) }

    var weekdayMedium:  String      { return Formatter.weekdayMedium.string(from: self) }
    
    var dayOfMonthMedium: String     { return Formatter.dayOfMonthMedium.string(from: self) }
    
    var yearMedium: String     { return Formatter.yearMedium.string(from: self) }
    
    var hourMedium: String     { return Formatter.hourMedium.string(from: self) }
    
    var amPM: String         { return Formatter.amPM.string(from: self) }
    
    var dateMedium: String         { return Formatter.dateMedium.string(from: self) }

        
    
    
    
    //- example of getting pre-formatted date strings
    
    func dateToStringFormat1() -> String {
        return "\(weekdayMedium), \(monthMediumShortened). \(dayOfMonthMedium)"
    }
    
    func dateToStringFormat2() -> String {
        return "\(weekdayMedium), \(monthMedium) \(dayOfMonthMedium), \(yearMedium)"
    }
    
    var iso8601: String {
        /// gives the iso8601 format of date as string
        return Formatter.iso8601.string(from: self)
    }
    
    
    
    
    //- example of shortened way to retrieve date elements as Int
    
    var hourAsInt: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    
    
}

// MARK: - FORMATTER EXTENSIONS

extension Formatter {
    
    
    //- Pre-formatting date elements to string

    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime])

    static let monthMediumShortened: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }()
    
        static let monthMedium: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM"
            return formatter
        }()
    
    static let weekdayMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    static let dayOfMonthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    static let yearMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static let hourMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        return formatter
    }()
    
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }()
    
    static let dateMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()
    
    static let dateShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/d/yyyy"
        return formatter
    }()
    
    
    //- Functions to convert string to date based on defined format(s)
    
    func getDateFromRFC822String(_ dateString: String) -> Date? {
        
        let formatter = DateFormatter()
        
        ///Fri, 25 Oct 2019 17:48:13 GMT
        formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss zzz"
        
        let date: Date? = formatter.date(from: dateString)
        return date
        
    }
    
    func getDateFromiso8601LongOrShort(_ dateString: String) -> Date? {
        //- Example of how to convert from multiple possible formats
        
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        
        //try long format
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let date = dateformatter.date(from:dateString) {
            return date
        }
        //try short format
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        if let date = dateformatter.date(from:dateString) {
            return date
        }
        
        return nil
        
    }
    
    //- Other cool functions
    
    func getStartEndTimes(startDateString: String, durationMinutes: String?) -> String {
        //- prints the start time and, if applicable, the end time.
        /// 4:00 - 5:15 PM    ;      11:00 AM - 1:00 PM     ;       4:20 PM
        
        var startString = ""
        var endString = ""

        //assuming date string is iso8601
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        if let startTime = dateFormatter.getDateFromiso8601LongOrShort(startDateString) {
            
            // get end time
            let duration = Int(durationMinutes ?? "0")
            let endTime = startTime.addingTimeInterval((TimeInterval((duration ?? 0)*60)))
            
            // check if both are same amPM
            var same: Bool {
                return startTime.amPM == endTime.amPM
            }

            // set up format and convert dates
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            dateFormatter.dateFormat = "h:mm a"
            endString = dateFormatter.string(from: endTime) /// endtime will always include AM/PM
            if same { dateFormatter.dateFormat = "h:mm"}  /// if same AM/PM, remove startTime's AM/PM
            startString = dateFormatter.string(from: startTime)
            
            // Check duration, combine and return
            if startTime == endTime { return endString} /// if duration wasn't given or was 0 min, only return end time (so it will include amPM)
            return "\(startString) - \(endString)"
            
        }
        print("date formatting error: \(startDateString)")
        return ""
    }
    
    
    func dateBetweenChecker(startDate: Date?, endDate: Date?, checkDate: Date?) -> Bool {
        //- Check if the date is between (not equal to) the start and end date
        /// NOTE: only compares dates, sets times to 00:00:00 to avoid confliction
        
        if checkDate == nil || startDate == nil || endDate == nil {return false}
        

        if let start = Calendar.current.date(bySettingHour: 0, minute: 00, second: 0, of: startDate ?? Date()) , let end = Calendar.current.date(bySettingHour: 0, minute: 00, second: 0, of: endDate ?? Date()) , let check = Calendar.current.date(bySettingHour: 0, minute: 00, second: 0, of: checkDate ?? Date()) {    /// note: dates are optional but will never default to Date since it's being checked before
            //create copies of dates with time values of 00:00:00
        
            if check > start && check < end {
                //if after start and before end, return true
                return true
            }
        }
        return false
    }
    

}

// MARK: - ISO8601DateFormatter EXTENSIONS
//TODO: Thomas, what does this do?
extension ISO8601DateFormatter {
    
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

// MARK: - VIEW EXTENSIONS

extension View {
    
    
    func addBorder<S>(_ color: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(color, lineWidth: width))
    }

//    func alert(forAlert state: Binding<AlertState>) -> some View {
//        return self.alert(isPresented: state.visible) {
//            AlertView.alert(forAlert: state.wrappedValue)
//        }
//    }
    
    //
    @available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}



// MARK: - STRING EXTENSIONS

extension String {
    
    //- Converts iso8601 string to Date
    var iso8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
    
    
    //MARK: CALL, TEXT AND EMAIL FUNCTIONS/VALIDATORS
    //TODO: Thomas, do you mind explaining how the RegularExpressions and validations works? - TY!
    
    //- Regex enums
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    }

    func isValid(regex: RegularExpressions) -> Bool { return isValid(regex: regex.rawValue) }
    func isValid(regex: String) -> Bool { return range(of: regex, options: .regularExpression) != nil }

    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }

    //- Function for making a phone call from string phone number
    func makeACall() {
        guard isValid(regex: .phone),
            let url = URL(string: "tel://\(self.onlyDigits())"),
            UIApplication.shared.canOpenURL(url) else { return }
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    //- Function for sending a text from string phone number
    func sendAText() {
        guard isValid(regex: .phone),
            let url = URL(string: "sms:\(self.onlyDigits())"),
            UIApplication.shared.canOpenURL(url) else { return }
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    //- Function for sending an email from string email
    func sendAnEmail() {
        guard isValid(regex: .email),
            let url = URL(string: "mailto:\(self)"),
            UIApplication.shared.canOpenURL(url) else { return }
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}


