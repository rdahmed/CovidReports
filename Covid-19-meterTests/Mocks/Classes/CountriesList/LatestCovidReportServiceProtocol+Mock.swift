//
//  LatestCovidReportServiceProtocol+Mock.swift
//  Covid-19-meterTests
//
//  Created by Radwa Ahmed on 27/04/2022.
//

import Foundation

@testable import Covid_19_meter

class LatestCovidReportServiceMock: LatestCovidReportServiceProtocol {
    
    var getLatestCovidCasesCalled = false
    
    var reports: [CountryCovidReport]?
    var error: Error?
    
    func getLatestCovidCases(completion: @escaping CompletionHandler<[CountryCovidReport]>) {
        self.getLatestCovidCasesCalled = true
        
        if let reports = reports {
            completion(.success(reports))
            return
        }
        
        if let error = error {
            completion(.failure(error))
            return
        }
        
    }
}

enum ErrorMock: Error {
    case fakeError
}

extension ErrorMock: LocalizedError {
    private var errorDescription: String {
        switch self {
        case .fakeError: return "a fake error message"
        }
    }
}
