//
//  CountriesListContracts.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import Foundation

protocol CountriesListViewModelOutputProtocol: AnyObject {
    func update(reports: [CountryCovidReport])
    func update(errorMessage: String)
}

protocol CountriesListViewModelInputProtocol: AnyObject {
    func fetchLatestCovidReports()
    func didTapOnCountry(_ index: Int)
}
