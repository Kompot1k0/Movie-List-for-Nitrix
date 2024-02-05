//
//  Date+Ext.swift
//  Movies
//
//  Created by Admin on 04.02.2024.
//

import Foundation

extension Date {
    
    func convertToDayMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter.string(from: self)
    }
}
