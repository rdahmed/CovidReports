//
//  NetworkServiceError.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

enum NetworkServiceError: Error {
    case noInternetConnection
    case invalidRequest
    case invalidMultipartFormRequest
    case invalidHTTPResponse
    case statusCodeNotAcceptable
    case emptyResponse
}

// MARK: - LocalizedError

extension NetworkServiceError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "Oops! Looks like there is no internet connection!"
            
        case .invalidRequest,
             .invalidMultipartFormRequest,
             .invalidHTTPResponse,
             .statusCodeNotAcceptable,
             .emptyResponse:
            return "Oops! Something went wrong. Please try again later."
        }
    }
    
}
