//
//  CountryTableViewCell.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let countryNameLabel = UILabel()
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        accessoryType = .detailDisclosureButton
        
        contentView.addSubview(countryNameLabel)
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countryNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            countryNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func setCountryName(_ name: String) {
        countryNameLabel.text = name
    }

}
