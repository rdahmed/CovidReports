//
//  CountryTableViewCell.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    // MARK: - Dependancies
        
    var report: CountryCovidReport? {
        didSet {
            guard let report = report else { return }
            updateUI(report)
        }
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private UI Helpers

private extension CountryTableViewCell {
    
    func updateUI(_ report: CountryCovidReport) {
        let config = makeConfig(report.countryName)
        contentConfiguration = config
    }

    func makeConfig(_ text: String) -> UIListContentConfiguration {
        var config = UIListContentConfiguration.cell()
        config.text = text
        return config
    }
    
}
