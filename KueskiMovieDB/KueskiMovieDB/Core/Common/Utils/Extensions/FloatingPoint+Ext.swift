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
        let value = Double(exactly: self) ?? 0.0
        
        // Format the number
        if value >= 1_000_000_000 {
            numberFormatter.positiveFormat = "0.0B"
            return numberFormatter.string(from: NSNumber(value: value / 1_000_000_000)) ?? "\(value)"
        } else if value >= 1_000_000 {
            numberFormatter.positiveFormat = "0.0M"
            return numberFormatter.string(from: NSNumber(value: value / 1_000_000)) ?? "\(value)"
        } else if value >= 1_000 {
            numberFormatter.positiveFormat = "0.0K"
            return numberFormatter.string(from: NSNumber(value: value / 1_000)) ?? "\(value)"
        } else {
            numberFormatter.maximumFractionDigits = 2
            return numberFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
        }
    }
}
