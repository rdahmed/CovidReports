//
//  CountriesListContracts.swift
//  CovidReports
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import Foundation

protocol CountriesListViewModelOutputProtocol: AnyObject {
    func update(reports: [CountryCovidReport])
    func update(errorMessage: String)
}

protocol CountriesListViewModelInputProtocol: AnyObject {
    func fetchLatestCovidReports(completion: (() -> Void)?)
    func searchCountries(_ searchText: String)
    func sortCountries(_ option: SortOption)
    func didTapOnCountry(_ index: Int)
}

extension CountriesListViewModelInputProtocol {
    func fetchLatestCovidReports(completion: (() -> Void)? = nil) {
        self.fetchLatestCovidReports(completion: completion)
    }
}
