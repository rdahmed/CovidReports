//
//  Formatters.swift
//  CovidReports
//
//  Created by Radwa Ahmed on 27/04/2022.
//

import Foundation

enum Formatters {
    
    static var apiDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .utc
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static var uiDisplay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy, hh:mm"
        return formatter
    }()
    
}

private extension TimeZone {
    static let utc = TimeZone(secondsFromGMT: .zero)
}
