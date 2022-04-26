//
//  CountriesListViewModel.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import Foundation

class CountriesListViewModel {
    
    // MARK: - Dependencies
    
    var countriesReports = [CountryCovidReport]() {
        didSet {
            self.view?.update(reports: countriesReports)
        }
    }
    var errorMessage: String?
    
    // MARK: - Properties
    
    var view: CountriesListViewModelOutputProtocol?
    
    private let latestReportsService: LatestCovidReportServiceProtocol
    private let router: CountriesListRouterProtocol
    
    // MARK: - Initializers
    
    init(
        service: LatestCovidReportServiceProtocol = LatestCovidReportService.default,
        router: CountriesListRouterProtocol
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
    
    func fetchLatestCovidReports(completion: (() -> Void)?) {
        self.latestReportsService.getLatestCovidCases { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let reports):
                self.countriesReports = reports.sorted { $0.countryName < $1.countryName }
                
            case .failure(let error):
                self.view?.update(errorMessage: error.localizedDescription)
            }
            
            completion?()
        }
    }
    
    func didTapOnCountry(_ index: Int) {
        let report = self.countriesReports[index]
        self.router.showCountryCovidReport(report)
    }
    
}

