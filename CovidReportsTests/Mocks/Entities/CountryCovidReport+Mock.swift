//
//  CountryCovidReport+Mock.swift
//  CovidReportsTests
//
//  Created by Radwa Ahmed on 27/04/2022.
//

@testable import CovidReports

extension CountryCovidReport {
    static func mock(countryName: String) -> CountryCovidReport {
        .init(
            countryName: countryName,
            dto: .mock())
    }
}

extension CountryCovidReport: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.countryName == rhs.countryName
    }

}
