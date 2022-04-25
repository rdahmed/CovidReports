//
//  JSONTransport.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

class JSONTransport: JSONTransportProtocol {
    
    // MARK: - GET
    
    func get<T>(
        _ type: T.Type,
        route: Route,
        queryItems: QueryItems = [:],
        headers: Headers = [:],
        completion: @escaping CompletionHandler<T>)
    where T: Decodable
    {
        perform(
            route: route,
            method: .get,
            queryItems: queryItems,
            headers: headers,
            completion: completion
        )
    }
    
}

private extension JSONTransport {
    
    func perform<T>(
        route: Route,
        method: HTTPMethod,
        queryItems: QueryItems = [:],
        headers: Headers = [:],
        body: HTTPBody = nil,
        completion: @escaping CompletionHandler<T>)
    where T: Decodable {
        
        NetworkService.shared.request(
            route: route,
            method: method,
            queryItems: queryItems,
            headers: headers,
            body: body)
        { result in
            switch result {
            case .success(let data):
                if let response = try? JSONDecoder().decode(T.self, from: data) {
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(JSONTransportError.unexpectedJSONFormat))
                    }
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
    }
    
}
