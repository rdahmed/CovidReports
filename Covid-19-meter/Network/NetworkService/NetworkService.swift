//
//  NetworkService.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

// MARK: - Network Service

class NetworkService: NetworkServiceProtocol {
    
    private init() {}
    static let shared: NetworkServiceProtocol = NetworkService()
        
    func request(
        route: Route,
        method: HTTPMethod,
        queryItems: QueryItems = [:],
        headers: Headers = [:],
        body: HTTPBody = nil,
        completion: @escaping CompletionHandler)
    {
        guard checkInternetConnection(completion: completion) else {
            return
        }
        
        guard let request = createRequest(
                route: route,
                method: method,
                queryItems: queryItems,
                headers: headers,
                body: body)
        else {
            completion(.failure(NetworkServiceError.invalidRequest))
            return
        }
        
        executeRequest(request, completion: completion)
    }
    
}

// MARK: - Executors

private extension NetworkService {
    
    func executeRequest(_ request: URLRequest, completion: @escaping CompletionHandler) {
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            self?.log(request: request, response: response, data: data, error: error)
            
            guard
                let self = self,
                self.checkError(error, completion: completion),
                self.checkResponse(response, completion: completion),
                self.checkData(data, completion: completion),
                let data = data
            else {
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
}

// MARK: - Checks

private extension NetworkService {
    
    func checkInternetConnection(completion: CompletionHandler) -> Bool {
        guard Reachability.shared.isReachable else {
            completion(.failure(NetworkServiceError.noInternetConnection))
            return false
        }
        
        return true
    }
    
    /// Returns true if no errors found
    func checkError(_ error: Error?, completion: CompletionHandler) -> Bool {
        if let error = error {
            completion(.failure(error))
            return false
        }
        
        return true
    }
    
    /// Returns ture if the response is valid HTTPResponse and statusCode is 2xx
    func checkResponse(_ response: URLResponse?, completion: CompletionHandler) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(NetworkServiceError.invalidHTTPResponse))
            return false
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(NetworkServiceError.statusCodeNotAcceptable))
            return false
        }
        
        return true
    }
    
    func checkData(_ data: Data?, completion: CompletionHandler) -> Bool {
        guard let data = data, !data.isEmpty else {
            completion(.failure(NetworkServiceError.emptyResponse))
            return false
        }
        
        return true
    }
}

// MARK: - Request Helpers

private extension NetworkService {
    
    func createRequest(
        route: Route,
        method: HTTPMethod = .get,
        queryItems: QueryItems = [:],
        headers: Headers = [:],
        body: HTTPBody)
    -> URLRequest?
    {
        guard let url = createURL(route, queryItems: queryItems) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        return request
    }
    
    func createURL(_ route: Route, queryItems: QueryItems = [:]) -> URL? {
        var urlString = HTTPConfig.baseURL + route.path
        
        let queryString = createQueryString(queryItems)
        urlString.append(queryString)
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed).orEmpty
        
        return URL(string: urlString)
    }
    
    func createQueryString(_ queryItems: QueryItems) -> String {
        let filteredQueryItems = queryItems.filter { !$0.value.isEmpty }
        guard !filteredQueryItems.isEmpty else { return .empty }
        
        return "?" +
            filteredQueryItems
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
    }
    
}

private extension NetworkService {
    
    func log(request: URLRequest, response: URLResponse?, data: Data?, error: Error?) {
        print("=======================================================")
        print("   ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓")
        print("URL:", request.url?.absoluteString ?? .empty)
        print("Method:", request.httpMethod ?? .empty)
        print("Headers:", request.allHTTPHeaderFields ?? String.empty)
        if let body = prettyString(request.httpBody) {
            print("HTTP Body:", body)
        }
        if let response = response as? HTTPURLResponse {
            print("Status:", response.statusCode)
        }
        if let responseJSON = prettyString(data) {
            print("Response:", responseJSON)
        }
        error.map { print("Error:", $0) }
        print("   ⬆===⬆===⬆===⬆===⬆===⬆===⬆===⬆===⬆===⬆===⬆")
        print("======================================================\n")
    }
    
    func prettyString(_ data: Data?) -> String? {
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
           let prettyData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let jsonString = String(data: prettyData, encoding: .utf8) {
            return jsonString
        } else {
            return nil
        }
    }
    
}
