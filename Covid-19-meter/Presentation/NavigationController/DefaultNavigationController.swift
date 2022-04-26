//
//  DefaultNavigationController.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 27/04/2022.
//

import UIKit

class DefaultNavigationController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupAppearance()
    }
    
    private func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
    
}
