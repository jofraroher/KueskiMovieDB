//
//  FloatingPoint+Ext.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

extension BinaryFloatingPoint {
    var formatted: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 0

        // Convert the value to Double
        let value = Double(self)
        let isNegative = value < 0
        let absValue = abs(value)
        
        // Format the number
        let formattedValue: String
        if absValue >= 1_000_000_000 {
            numberFormatter.positiveFormat = "0.0B"
            formattedValue = numberFormatter.string(from: NSNumber(value: absValue / 1_000_000_000)) ?? "\(absValue)"
        } else if absValue >= 1_000_000 {
            numberFormatter.positiveFormat = "0.0M"
            formattedValue = numberFormatter.string(from: NSNumber(value: absValue / 1_000_000)) ?? "\(absValue)"
        } else if absValue >= 1_000 {
            numberFormatter.positiveFormat = "0.0K"
            formattedValue = numberFormatter.string(from: NSNumber(value: absValue / 1_000)) ?? "\(absValue)"
        } else {
            numberFormatter.maximumFractionDigits = 2
            formattedValue = numberFormatter.string(from: NSNumber(value: absValue)) ?? "\(absValue)"
        }

        return isNegative ? "-\(formattedValue)" : formattedValue
    }
}
