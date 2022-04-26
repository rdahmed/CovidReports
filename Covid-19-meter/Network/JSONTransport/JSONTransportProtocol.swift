//
//  JSONTransportProtocol.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

protocol JSONTransportProtocol {
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void where T: Decodable
    
    // MARK: - GET
    
    func get<T>(
        _ type: T.Type,
        route: Route,
        queryItems: QueryItems,
        headers: Headers,
        completion: @escaping CompletionHandler<T>)
    where T: Decodable
    
}
