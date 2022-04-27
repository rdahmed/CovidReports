//
//  HTTPConfig.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

enum HTTPConfig {
    
    enum Environment {
        case production
    }

    static let environment: Environment = {
        return .production
    }()
    
    static var baseURL: String {
        
        switch environment {
        case .production:
            return "https://covid-api.mmediagroup.fr/v1"
        }
        
    }
}
