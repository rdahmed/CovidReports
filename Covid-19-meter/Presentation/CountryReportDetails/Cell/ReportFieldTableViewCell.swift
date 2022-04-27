//
//  ReportFieldTableViewCell.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 27/04/2022.
//

import UIKit

class ReportFieldTableViewCell: UITableViewCell {
    
    // MARK: - Dependancies
        
    var fieldData: ReportFieldData? {
        didSet {
            guard let fieldData = fieldData else { return }
            updateUI(fieldData)
        }
    }
    
}

// MARK: - Private UI Helpers

private extension ReportFieldTableViewCell {
    
    func updateUI(_ fieldData: ReportFieldData) {
        let config = makeConfig(
            text: fieldData.name,
            secondaryText: fieldData.value
        )
        
        contentConfiguration = config
    }

    func makeConfig(text: String, secondaryText: String) -> UIListContentConfiguration {
        var config = UIListContentConfiguration.cell()
        
        config.text = text
        config.textProperties.font = .systemFont(ofSize: 20, weight: .light)
        config.secondaryTextProperties.color = .darkGray
        
        config.secondaryText = secondaryText
        config.secondaryTextProperties.font = .systemFont(ofSize: 18, weight: .semibold)
        config.secondaryTextProperties.color = .black
        
        return config
    }
    
}
