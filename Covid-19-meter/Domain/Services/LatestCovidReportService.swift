//
//  LatestCovidReportService.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

class LatestCovidReportService: LatestCovidReportServiceProtocol {
    
    private init() {}
    static let `default` = LatestCovidReportService()
    
    private let jsonTransport = JSONTransport()
    
    func getLatestCovidCases(completion: @escaping CompletionHandler<[CountryCovidReport]>) {
        jsonTransport.get(LatestCovidReportDTO.self, route: .getLatestCovidCases) { result in
            switch result {
            case .success(let dto):
                let reports = dto.map { CountryCovidReport(countryName: $0.key, dto: $0.value) }
                completion(.success(reports))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
