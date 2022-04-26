//
//  CountriesListViewModel.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import Foundation

class CountriesListViewModel {
    
    // MARK: - Dependencies
    
    var allReports = [CountryCovidReport]()
    var countries = [String]() {
        didSet {
            view.update(countries: countries)
        }
    }
    
    // MARK: - Properties
    
    let view: CountriesListOutputProtocol
    let router: CountriesListRouter
    
    // MARK: - Initializers
    
    init(
        _ view: CountriesListOutputProtocol,
        router: CountriesListRouter)
    {
        self.view = view
        self.router = router
    }
    
    deinit {
        print(">>>>>>> CountriesListViewModel.deinit")
    }
    
    func getCountries() {
        LatestCovidReportService.default.getLatestCovidCases { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let report):
                self.allReports = report.countries
                self.countries = report.countries.map { $0.name }
                
            case .failure(let error):
                self.view.update(errorMessage: error.localizedDescription)
            }
        }
    }
    
}

// MARK: - ViewModelInput

extension CountriesListViewModel: CountriesListInputProtocol {
    
    func viewWillAppear() {
        getCountries()
    }
    
    func didTapOnCountry() {
        // TODO: Route to next screen
    }
    
}
