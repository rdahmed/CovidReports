//
//  CountriesListViewModel.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import Foundation

class CountriesListViewModel {
    
    // MARK: - Dependencies
    
    var view: CountriesListViewModelOutputProtocol?
    
    private let service: LatestCovidReportServiceProtocol
    private let router: CountriesListRouterProtocol
    
    // MARK: - Properties
    
    private var rawReports: [CountryCovidReport] = [] {
        didSet {
            self.view?.update(reports: self.displayReports)
        }
    }
    
    private var displayReports: [CountryCovidReport] {
        return self.rawReports
            .filter(self.filterCriteria)
            .sorted(by: self.reportsSortCriteria)
    }
    
    private var searchText: String = .empty {
        didSet {
            self.view?.update(reports: self.displayReports)
        }
    }
    private var sortOption: SortOption = .countryName {
        didSet {
            self.view?.update(reports: self.displayReports)
        }
    }
    
    // MARK: - Initializers
    
    init(
        service: LatestCovidReportServiceProtocol = LatestCovidReportService.default,
        router: CountriesListRouterProtocol
    ) {
        self.service = service
        self.router = router
    }
    
    deinit {
        print(#function, #file)
    }
    
}

// MARK: - ViewModelInput

extension CountriesListViewModel: CountriesListViewModelInputProtocol {
    
    func fetchLatestCovidReports(completion: (() -> Void)?) {
        self.service.getLatestCovidCases { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let reports):
                self.rawReports = reports
                
            case .failure(let error):
                self.view?.update(errorMessage: error.localizedDescription)
            }
            
            completion?()
        }
    }
    
    func searchCountries(_ searchText: String) {
        self.searchText = searchText
    }
    
    func sortCountries(_ option: SortOption) {
        self.sortOption = option
    }
    
    func didTapOnCountry(_ index: Int) {
        let report = self.displayReports[index]
        self.router.showCountryCovidReport(report)
    }
    
    func reportsSortCriteria(lhs: CountryCovidReport, rhs: CountryCovidReport) -> Bool {
        switch sortOption {
        case .countryName:
            return lhs.countryName < rhs.countryName
            
        case .activeCases:
            return lhs.activeCases > rhs.activeCases
            
        case .deaths:
            return lhs.deaths > rhs.deaths
            
        case .activeCasesFor100kHab:
            return (lhs.activeCasesFor100kHab ?? 0) > (rhs.activeCasesFor100kHab ?? 0)
            
        case .deathsFor100kHab:
            return (lhs.deathsFor100kHab ?? 0) > (rhs.deathsFor100kHab ?? 0)
        }
    }
    
    func filterCriteria(_ report: CountryCovidReport) -> Bool {
        if self.searchText.isEmpty { return true }
        return report.countryName.lowercased().contains(self.searchText.lowercased())
    }
    
}
