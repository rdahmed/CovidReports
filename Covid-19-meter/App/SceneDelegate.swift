//
//  SceneDelegate.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let router = CountriesListRouter()
        let viewModel = CountriesListViewModel(router: router)
        let viewController = CountriesListViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }

}
