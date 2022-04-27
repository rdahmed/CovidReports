//
//  Route+Path.swift
//  CovidReports
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

extension Route {
    
    var path: String {
        switch self {
        case .getLatestCovidCases: return "/cases"
        }
    }
    
}
