//
//  NetworkServiceProtocol.swift
//  CovidReports
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

protocol NetworkServiceProtocol {
    
    typealias CompletionHandler = (Result<Data, Error>) -> Void

    func request(
        route: Route,
        method: HTTPMethod,
        queryItems: QueryItems,
        headers: Headers,
        body: HTTPBody,
        completion: @escaping CompletionHandler)
    
}
