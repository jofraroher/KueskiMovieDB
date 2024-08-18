//
//  Date+Ext.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

extension Date {
    func toFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func subtracting(years: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .year, value: -years, to: self) ?? Date()
    }
}
