//
//  CountriesListRouterProtocol+Mock.swift
//  Covid-19-meterTests
//
//  Created by Radwa Ahmed on 27/04/2022.
//

@testable import Covid_19_meter

class CountriesListRouterMock: CountriesListRouterProtocol {
    
    var showCountryCovidReportCalled = false
    var selectedCountryCovidReport: CountryCovidReport?
    
    func showCountryCovidReport(_ report: CountryCovidReport) {
        self.showCountryCovidReportCalled = true
        self.selectedCountryCovidReport = report
    }
}
