//
//  DateHelper.swift
//  Vera
//
//  Created by Justin Cabral on 12/19/20.
//

import Foundation

extension Date {
    
    static var dayNumber: Double {
        let date = Date()
        let cal = Calendar.current
        guard let day = cal.ordinality(of: .day, in: .year, for: date) else { return 1 }
        
        return Double(day)
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
