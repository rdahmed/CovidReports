//
//  JSONTransportError.swift
//  CovidReports
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

enum JSONTransportError: Error {
    case unexpectedJSONFormat
}

extension JSONTransportError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unexpectedJSONFormat:
            return "Couldn't decode. Unexpected JSON format is returned!"
        }
    }
}
