//
//  SortOption.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 27/04/2022.
//

import Foundation

enum SortOption: CaseIterable {
    case countryName
    case activeCases
    case deaths
    case activeCasesFor100kHab
    case deathsFor100kHab
    
    var localized: String {
        switch self {
        case .countryName:
            return "Country Name"
        case .activeCases:
            return "Number of Active Cases"
        case .deaths:
            return "Number of Deaths"
        case .activeCasesFor100kHab:
            return "Active Cases for 100K Hab"
        case .deathsFor100kHab:
            return "Deaths for 100K Hab"
        }
    }
}
