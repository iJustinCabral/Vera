//
//  DateHelper.swift
//  Vera
//
//  Created by Justin Cabral on 12/19/20.
//

// swiftlint:disable trailing_whitespace

import Foundation

extension Date {

    static var dayNumber: Double {
        let date = Date()
        let cal = Calendar.current
        guard let day = cal.ordinality(of: .day, in: .year, for: date) else { return 1 }

        return Double(day)
    }
    
    func dayOfWeek() -> String? {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "EEEE"
         return dateFormatter.string(from: self).capitalized
         // or use capitalized(with: locale) if you want
     }
    
    func timeForDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let output = dateFormatter.string(from: date)
        return output
    }

    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {

        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }

    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format

            return outputFormatter.string(from: date)
        }

        return nil
    }

    static func numberForDate(_ date: Date) -> Double {

        let cal = Calendar.current
        guard let day = cal.ordinality(of: .day, in: .year, for: date) else { return 1 }

        return Double(day)
    }
}

/*
 let dateFormatter = DateFormatter()
 dateFormatter.dateFormat = "HH:mm:ss"
 var dateFromStr = dateFormatter.date(from: "12:16:45")!

 dateFormatter.dateFormat = "hh:mm:ss a 'on' MMMM dd, yyyy"
 //Output: 12:16:45 PM on January 01, 2000

 dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
 //Output: Sat, 1 Jan 2000 12:16:45 +0600

 dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
 //Output: 2000-01-01T12:16:45+0600

 dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
 //Output: Saturday, Jan 1, 2000

 dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
 //Output: 01-01-2000 12:16

 dateFormatter.dateFormat = "MMM d, h:mm a"
 //Output: Jan 1, 12:16 PM

 dateFormatter.dateFormat = "HH:mm:ss.SSS"
 //Output: 12:16:45.000

 dateFormatter.dateFormat = "MMM d, yyyy"
 //Output: Jan 1, 2000

 dateFormatter.dateFormat = "MM/dd/yyyy"
 //Output: 01/01/2000

 dateFormatter.dateFormat = "hh:mm:ss a"
 //Output: 12:16:45 PM

 dateFormatter.dateFormat = "MMMM yyyy"
 //Output: January 2000

 dateFormatter.dateFormat = "dd.MM.yy"
 //Output: 01.01.00

 //Output: Customisable AP/PM symbols
 dateFormatter.amSymbol = "am"
 dateFormatter.pmSymbol = "Pm"
 dateFormatter.dateFormat = "a"
 //Output: Pm

 // Usage
 var timeFromDate = dateFormatter.string(from: dateFromStr)
 print(timeFromDate)
 */
