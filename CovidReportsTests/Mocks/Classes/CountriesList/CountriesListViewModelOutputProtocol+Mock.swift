//
//  CountriesListViewModelOutputProtocol+Mock.swift
//  CovidReportsTests
//
//  Created by Radwa Ahmed on 27/04/2022.
//

@testable import CovidReports

class CountriesListViewModelOutputMock: CountriesListViewModelOutputProtocol {
    
    var updateReportsCalled = false
    var updatedReports: [CountryCovidReport]?
    
    var updateErrorMessageCalled = false
    var updatedErrorMessage: String?
    
    func update(reports: [CountryCovidReport]) {
        self.updateReportsCalled = true
        self.updatedReports = reports
    }
    
    func update(errorMessage: String) {
        self.updateErrorMessageCalled = true
        self.updatedErrorMessage = errorMessage
    }
}
