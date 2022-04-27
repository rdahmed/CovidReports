//
//  LatestCovidReportDTO.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

typealias LatestCovidReportDTO = [String: CountryCovidReportDTO]

struct CountryCovidReportDTO: Decodable {
    let confirmed: Int
    let recovered: Int
    let deaths: Int
    let country: String?
    let population: Int?
    let continent: String?
    let abbreviation: String?
    let updated: String?
    
    enum CodingKeys: String, CodingKey {
        case all = "All"
    }
    
    enum ReportKeys: String, CodingKey {
        case confirmed
        case recovered
        case deaths
        case country
        case population
        case continent
        case abbreviation
        case updated
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let report = try container.nestedContainer(keyedBy: ReportKeys.self, forKey: .all)
                
        self.confirmed = try report.decode(Int.self, forKey: .confirmed)
        self.recovered = try report.decode(Int.self, forKey: .recovered)
        self.deaths = try report.decode(Int.self, forKey: .deaths)
        self.country = try report.decodeIfPresent(String.self, forKey: .country)
        self.population = try report.decodeIfPresent(Int.self, forKey: .population)
        self.continent = try report.decodeIfPresent(String.self, forKey: .continent)
        self.abbreviation = try report.decodeIfPresent(String.self, forKey: .abbreviation)
        self.updated = try report.decodeIfPresent(String.self, forKey: .updated)
    }
    
    init(
        confirmed: Int,
        recovered: Int,
        deaths: Int,
        country: String?,
        population: Int?,
        continent: String?,
        abbreviation: String?,
        updated: String?
    ) {
        self.confirmed = confirmed
        self.recovered = recovered
        self.deaths = deaths
        self.country = country
        self.population = population
        self.continent = continent
        self.abbreviation = abbreviation
        self.updated = updated
    }
}
