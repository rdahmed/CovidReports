//
//  CountryReportViewModel.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import Foundation

class CountryReportViewModel: CountryReportViewModelInputProtocol {
    
    // MARK: - Dependencies
    
    var view: CountryReportViewModelOutputProtocol?
    
    private let countryReport: CountryCovidReport
    private var reportFields: [ReportFieldData] = [] {
        didSet {
            view?.update(reportFields: reportFields)
        }
    }
    
    // MARK: - Initializers
    
    init(countryReport: CountryCovidReport) {
        self.countryReport = countryReport
    }
    
    func fetchReportFields() {
        self.reportFields = makeReportFieldsData(countryReport)
    }
    
    deinit {
        print(#function, #file)
    }
    
}

private extension CountryReportViewModel {
    
    func makeReportFieldsData(_ report: CountryCovidReport) -> [ReportFieldData] {
        var lastUpdateDate: String
        if let date = report.lastUpdateDate {
            lastUpdateDate = Formatters.uiDisplay.string(from: date)
        } else {
            lastUpdateDate = "-"
        }
        
        return [
            .init(name: "Number of active cases", value: "\(report.activeCases)"),
            .init(name: "Number of deaths", value: "\(report.deaths)"),
            .init(name: "Active cases for 100K hab", value: report.activeCasesFor100kHab.map { "\($0)" } ?? "-"),
            .init(name: "Deaths for 100K hab", value: report.deathsFor100kHab.map { "\($0)" } ?? "-"),
            .init(name: "Date of last update", value: lastUpdateDate)
        ]
    }
    
}
