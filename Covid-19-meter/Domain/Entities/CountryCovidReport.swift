//
//  CountryCovidReport.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

struct CountryCovidReport: Decodable {
    let countryName: String
    let population: Int
    let activeCases: Int
    let deaths: Int
    let lastUpdateDate: Date
    
    // FIXME: Move these to UIModel
    var activeCasesFor100kHab: Int {
        let percentageOfActiveCases: Double = Double(activeCases) / Double(population)
        return Int(percentageOfActiveCases * 100_000)
    }
    
    var deathsFor100kHab: Int {
        let percentageOfDeaths: Double = Double(deaths) / Double(population)
        return Int(percentageOfDeaths * 100_000)
    }
}
