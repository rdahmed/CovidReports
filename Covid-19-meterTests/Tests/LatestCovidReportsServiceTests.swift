//
//  LatestCovidReportsServiceTests.swift
//  Covid-19-meterTests
//
//  Created by Radwa Ahmed on 27/04/2022.
//

import XCTest

@testable import Covid_19_meter

class LatestCovidReportsServiceTests: XCTestCase {
    
    var jsonTransport: JSONTransportMock!
    var sut: LatestCovidReportService!
    
    override func setUp() {
        self.jsonTransport = JSONTransportMock()
        self.sut = LatestCovidReportService(self.jsonTransport)
    }
    
    override func tearDown() {
        self.jsonTransport = nil
        self.sut = nil
    }
    
    func testGetLatestCovidReports() {
        // Given
        
        // When
        self.sut.getLatestCovidCases { _ in /* NOTHING TO DO HERE */ }
        
        // Assert
        XCTAssertTrue(self.jsonTransport.getCalled)
        XCTAssertEqual(self.jsonTransport.route, .getLatestCovidCases)
    }

}

