//
//  CountriesListRouter.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import Foundation

protocol CountriesListRouterProtocol: AnyObject {
    func showCountryCovidReport(_ report: CountryCovidReport)
}
