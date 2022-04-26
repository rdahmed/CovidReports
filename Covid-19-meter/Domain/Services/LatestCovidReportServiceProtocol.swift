//
//  LatestCovidReportServiceProtocol.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

protocol LatestCovidReportServiceProtocol: AnyObject {
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void where T: Decodable
    
    func getLatestCovidCases(completion: @escaping CompletionHandler<[CountryCovidReport]>)
}
