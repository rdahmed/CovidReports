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
        
        self.setupAppearance()
    }
    
    private func setupAppearance() {
        self.view.backgroundColor = .systemBackground
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = self.navigationBar.standardAppearance
    }
    
}
