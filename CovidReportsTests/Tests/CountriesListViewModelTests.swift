//
//  CountriesListViewModelTests.swift
//  CovidReports
//
//  Created by Radwa Ahmed on 27/04/2022.
//

import XCTest

@testable import CovidReports

class CountriesListViewModelTest: XCTestCase {
    
    var view: CountriesListViewModelOutputMock!
    var router: CountriesListRouterMock!
    var service: LatestCovidReportServiceMock!
    
    var sut: CountriesListViewModel!
    
    let mockReports: [CountryCovidReport] = [
        .mock(countryName: "a string"),
        .mock(countryName: "another country"),
        .mock(countryName: "country")
    ]
    
    override func setUp() {
        self.view = CountriesListViewModelOutputMock()
        self.router = CountriesListRouterMock()
        self.service = LatestCovidReportServiceMock()
        
        self.sut = CountriesListViewModel(
            service: self.service,
            router: self.router
        )
        
        self.sut.view = self.view
    }
    
    override func tearDown() {
        self.view = nil
        self.router = nil
        self.service = nil
        self.sut = nil
    }

    // MARK: - Test Service Calls
    
    func testServiceIsCalled_whenFetchLatestReportsIsCalled() {
        // Given
        self.service.reports = self.mockReports
        
        // When
        self.sut.fetchLatestCovidReports { /* NOTHING TO DO HERE */ }
        
        // Assert
        XCTAssertTrue(self.service.getLatestCovidCasesCalled)
        XCTAssertEqual(self.sut.displayReports, self.mockReports)
    }
    
    func testViewIsCalled_whenFetchServiceIsFailed() {
        // Given
        self.service.error = ErrorMock.fakeError
        
        // When
        self.sut.fetchLatestCovidReports { /* NOTHING TO DO HERE */ }
        
        // Assert
        XCTAssertTrue(self.view.updateErrorMessageCalled)
        XCTAssertEqual(self.view.updatedErrorMessage, ErrorMock.fakeError.localizedDescription)
    }
    
    // MARK: - Test Filter
    
    func testFilter_whenSearchTextIsPassed() {
        // Given
        self.service.reports = self.mockReports
        self.sut.fetchLatestCovidReports { /* NOTHING TO DO HERE */ }
        
        // When
        self.sut.searchCountries("country")
        
        // Assert
        let expectedCountries: [CountryCovidReport] = [
            .mock(countryName: "another country"),
            .mock(countryName: "country")
        ]
        
        XCTAssertEqual(self.sut.displayReports.count, expectedCountries.count)
        XCTAssertEqual(self.sut.displayReports, expectedCountries)
    }
    
    func testFilter_whenEmptySearchTextIsPassed() {
        // Given
        self.service.reports = self.mockReports
        self.sut.fetchLatestCovidReports { /* NOTHING TO DO HERE */ }
        
        // When
        self.sut.searchCountries(.empty)
        
        // Assert
        XCTAssertEqual(self.sut.displayReports.count, self.mockReports.count)
        XCTAssertEqual(self.sut.displayReports, self.mockReports)
    }
    
    // MARK: - Test Country Tap
    
    func testRouterIsCalled_whenCountryReportIsPressed() {
        let selectedIndex = 1
        
        // Given
        self.service.reports = self.mockReports
        self.sut.fetchLatestCovidReports { /* NOTHING TO DO HERE */ }
        
        // When
        self.sut.didTapOnCountry(selectedIndex)
        
        // Assert
        XCTAssertTrue(self.router.showCountryCovidReportCalled)
        XCTAssertEqual(self.router.selectedCountryCovidReport, self.mockReports[selectedIndex])
    }
    
    // MARK: - Test Sort
    
    func testSortCountries_whenSortedByCountryName() {
        // Given
        self.service.reports = self.mockReports.shuffled()
        self.sut.fetchLatestCovidReports { /* NOTHING TO DO HERE */ }
        
        // When
        self.sut.sortCountries(.countryName)
        
        // Assert
        let expectedCountries = self.mockReports.sorted { $0.countryName < $1.countryName }
        XCTAssertEqual(self.sut.displayReports, expectedCountries)
    }
    
    func testSortCountries_whenSortedByActiveCases() {
        // Given
        self.service.reports = self.mockReports.shuffled()
        self.sut.fetchLatestCovidReports { /* NOTHING TO DO HERE */ }
        
        // When
        self.sut.sortCountries(.activeCases)
        
        // Assert
        let expectedCountries = self.mockReports.sorted { $0.activeCases > $1.activeCases }
        XCTAssertEqual(self.sut.displayReports, expectedCountries)
    }
    
    func testSortCountries_whenSortedByDeaths() {
        // Given
        self.service.reports = self.mockReports.shuffled()
        self.sut.fetchLatestCovidReports { /* NOTHING TO DO HERE */ }
        
        // When
        self.sut.sortCountries(.deaths)
        
        // Assert
        let expectedCountries = self.mockReports.sorted { $0.deaths > $1.deaths }
        XCTAssertEqual(self.sut.displayReports, expectedCountries)
    }
    
    func testSortCountries_whenSortedByActiveCasesFor100kHab() {
        // Given
        self.service.reports = self.mockReports.shuffled()
        self.sut.fetchLatestCovidReports { /* NOTHING TO DO HERE */ }
        
        // When
        self.sut.sortCountries(.activeCasesFor100kHab)
        
        // Assert
        let expectedCountries = self.mockReports
            .sorted { $0.activeCasesFor100kHab ?? .zero > $1.activeCasesFor100kHab ?? .zero }
        XCTAssertEqual(self.sut.displayReports, expectedCountries)
    }
    
    func testSortCountries_whenSortedByDeathsFor100kHab() {
        // Given
        self.service.reports = self.mockReports.shuffled()
        self.sut.fetchLatestCovidReports { /* NOTHING TO DO HERE */ }
        
        // When
        self.sut.sortCountries(.deathsFor100kHab)
        
        // Assert
        let expectedCountries = self.mockReports
            .sorted { $0.deathsFor100kHab ?? .zero > $1.deathsFor100kHab ?? .zero }
        XCTAssertEqual(self.sut.displayReports, expectedCountries)
    }
    

}
