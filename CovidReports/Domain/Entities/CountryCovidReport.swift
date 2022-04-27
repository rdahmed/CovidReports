//
//  CountryCovidReport.swift
//  CovidReports
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

struct CountryCovidReport: Decodable {
    let countryName: String
    let population: Int?
    let activeCases: Int
    let deaths: Int
    let lastUpdateDate: Date?
    
    init(countryName: String, dto: CountryCovidReportDTO) {
        self.countryName = countryName
        
        self.population = dto.population
        self.activeCases = dto.confirmed
        self.deaths = dto.deaths
        
        if let updated = dto.updated {
            self.lastUpdateDate = Formatters.apiDate.date(from: updated)
        } else {
            self.lastUpdateDate = nil
        }
    }
}

extension CountryCovidReport {
    
    var activeCasesFor100kHab: Int? {
        guard let population = population else {
            return nil
        }

        let percentageOfActiveCases: Double = Double(activeCases) / Double(population)
        return Int(percentageOfActiveCases * 100_000)
    }
    
    var deathsFor100kHab: Int? {
        guard let population = population else {
            return nil
        }
        
        let percentageOfDeaths: Double = Double(deaths) / Double(population)
        return Int(percentageOfDeaths * 100_000)
    }
    
}
