//
//  Date+Extension.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation

enum DateFormat: String {
    case monthNameDayYear12hrTime = "MMM-dd-yyyy, hh:mm a"
    case monthNameDayYear24hrTime = "MMM-dd-yyyy, HH:mm"
    case normalDateFormat = "MM/dd/YYYY"
    case timeFormat = "HH:mm"
    case dayName = "EEEE"
}

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}

extension Formatter {
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    
    var isoDateString: String {
        return ISO8601DateFormatter().string(from: self)
    }
    
    func dateString(_ format: String = "MMM-dd-YYYY, hh:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    
    func dateByAddingDay(_ day: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.day = day
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    
    static func fromString(dateString: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
    
    static func fromString(ISOString string: String) -> Date? {
        let newDateStr = string.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
        return ISO8601DateFormatter().date(from: newDateStr)
    }
    
    var iso8601withFractionalSeconds: String { return Formatter.iso8601withFractionalSeconds.string(from: self) }
    
    var unixTimestamp: Double {
        return (self.timeIntervalSince1970 * 1_000) // millisecond precision
    }
    
    var isExpired: Bool {
        let now = Date()
        return self.compare(now) == ComparisonResult.orderedAscending
    }
}
