//
//  Double+Extension.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation

extension Formatter {
    static func withSeparator(separator: String, places: Int = 2) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = separator
        formatter.groupingSeparator = ","
        formatter.minimumFractionDigits = places
        return formatter
    }
}

extension Double {
    var roundedString: String {
        return "\(self.rounded(toPlaces: 2).stringWithoutZeroFraction)"
    }
    
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Double {
    func asDurationString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
    
    func toDurationString() -> String {
        var val = self
        if self.isNaN {
            val = 0
        }
        let minute = Int(val) / 60
        let second = Int(val) % 60
        
        // return formated string
        return String(format: "%02i:%02i", minute, second)
    }
}

extension Int {
    var toDouble: Double {
        return Double(self)
    }
}
