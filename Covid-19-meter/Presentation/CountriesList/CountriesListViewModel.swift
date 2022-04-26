//
//  CountriesListViewModel.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import Foundation

class CountriesListViewModel {
    
    // MARK: - Dependencies
    
    var countriesReports = [CountryCovidReport]()
    var errorMessage: String?
    
    // MARK: - Properties
    
    var view: CountriesListViewModelOutputProtocol?
    
    private let latestReportsService: LatestCovidReportServiceProtocol
    private let router: CountriesListRouter
    
    // MARK: - Initializers
    
    init(
        service: LatestCovidReportServiceProtocol = LatestCovidReportService.default,
        router: CountriesListRouter
    ) {
        self.latestReportsService = service
        self.router = router
    }
    
    deinit {
        print(#function, #file)
    }
    
}

// MARK: - ViewModelInput

extension CountriesListViewModel: CountriesListViewModelInputProtocol {
    
    func fetchLatestCovidReports() {
        self.latestReportsService.getLatestCovidCases { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let reports):
                self.countriesReports = reports
                
                let sortedReports = self.countriesReports.sorted { $0.countryName < $1.countryName }
                self.view?.update(reports: sortedReports)
                
            case .failure(let error):
                self.view?.update(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func didTapOnCountry(_ index: Int) {
        print(#function, index)
        // TODO: Route to next screen
    }
    
}

