//
//  LatestCovidReportDTO.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

struct LatestCovidReportDTO: Decodable {
    let countries: [String: CountryCovidReportWrapperDTO]
    
    func mapToEntity() -> [CountryCovidReport] {
        let countriesReportsDTO = self.countries.values.map { $0.all }
        let countries = countriesReportsDTO.map { $0.mapToEntity() }
        return countries
    }
}

struct CountryCovidReportWrapperDTO: Decodable {
    let all: CountryCovidReportDTO
}

struct CountryCovidReportDTO: Decodable {
    let confirmed: Int
    let recovered: Int
    let deaths: Int
    let country: String
    let population: Int
    let continent: String
    let abbreviation: String
    let updated: String
    
    func mapToEntity() -> CountryCovidReport {
        .init(
            countryName: self.country,
            population: self.population,
            activeCases: self.confirmed,
            deaths: self.deaths,
            lastUpdateDate: Date() //dto.updated // FIXME: Use formatter
        )
    }
}
