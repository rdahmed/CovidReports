//
//  CountriesListContracts.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import Foundation

protocol CountriesListOutputProtocol: AnyObject {
    func update(countries: [String])
    func update(errorMessage: String)
}

protocol CountriesListInputProtocol: AnyObject {
    func viewWillAppear()
    func didTapOnCountry()
}
