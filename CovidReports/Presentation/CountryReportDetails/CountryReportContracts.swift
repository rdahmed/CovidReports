//
//  CountryReportContracts.swift
//  CovidReports
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import Foundation

protocol CountryReportViewModelOutputProtocol: AnyObject {
    func update(reportFields: [ReportFieldData])
}

protocol CountryReportViewModelInputProtocol: AnyObject {
    func fetchReportFields()
}
