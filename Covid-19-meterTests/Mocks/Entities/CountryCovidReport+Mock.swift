//
//  CountryCovidReport+Mock.swift
//  Covid-19-meterTests
//
//  Created by Radwa Ahmed on 27/04/2022.
//

@testable import Covid_19_meter

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
