//
//  HTTPConfig.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

enum HTTPConfig {
    
    enum Environment {
        case staging
        case production
    }

    static let environment: Environment = {
        #if DEBUG
        return .staging
        #else
        return .production
        #endif
    }()
    
    static var baseURL: String {
        
        switch environment {
        case .staging:
            return "https://covid-api.mmediagroup.fr/v1"

        case .production:
            return "https://covid-api.mmediagroup.fr/v1"
            
        }
        
    }
}
