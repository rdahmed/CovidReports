//
//  MainCoordinator.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import UIKit

class MainCoordinator {
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.navigationController = DefaultNavigationController()
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    func run() {
        let viewModel = CountriesListViewModel(router: self)
        let viewController = CountriesListViewController(viewModel: viewModel)
        
        viewController.title = "Countries List"
        viewModel.view = viewController
        
        navigationController.viewControllers = [viewController]
    }
}

extension MainCoordinator: CountriesListRouterProtocol {
    
    func showCountryCovidReport(_ report: CountryCovidReport) {
        let viewModel = CountryReportViewModel(countryReport: report)
        let viewController = CountryReportViewController(viewModel: viewModel)
        
        viewController.title = "\(report.countryName)'s Report"
        viewModel.view = viewController
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
