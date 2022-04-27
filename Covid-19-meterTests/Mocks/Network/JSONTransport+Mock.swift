//
//  JSONTransport+Mock.swift
//  Covid-19-meterTests
//
//  Created by Radwa Ahmed on 27/04/2022.
//

import Foundation

@testable import Covid_19_meter

class JSONTransportMock: JSONTransportProtocol {
    
    var getCalled = false
    var route: Route?
    
    func get<T>(
        _ type: T.Type,
        route: Route,
        queryItems: QueryItems,
        headers: Headers,
        completion: @escaping CompletionHandler<T>
    ) where T : Decodable {
        self.getCalled = true
        self.route = route
    }
    
}
