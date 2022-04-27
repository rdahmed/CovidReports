//
//  CountryCovidReportDTO+Mock.swift
//  Covid-19-meterTests
//
//  Created by Radwa Ahmed on 27/04/2022.
//

@testable import Covid_19_meter

extension CountryCovidReportDTO {
    static func mock(
        confirmed: Int = .random(in: 0...1000),
        recovered: Int = .random(in: 0...1000),
        deaths: Int = .random(in: 0...1000),
        country: String? = nil,
        population: Int? = .random(in: 0...1000),
        continent: String? = nil,
        abbreviation: String? = nil,
        updated: String? = nil
    ) -> CountryCovidReportDTO {
        .init(
            confirmed: confirmed,
            recovered: recovered,
            deaths: deaths,
            country: country,
            population: population,
            continent: continent,
            abbreviation: abbreviation,
            updated: updated
        )
    }
}
