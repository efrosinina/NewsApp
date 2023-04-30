//
//  TabBarController.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 30/04/2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: -- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = .black
        setupViewController()
    }
    
    //MARK: -- Private methods
    private func setupViewController() {
        viewControllers = [
            setupNavigationController(rootViewController: GeneralViewController(),
                                      title: "General".localized,
                                      image: UIImage(systemName: "newspaper") ?? UIImage.add),
            setupNavigationController(rootViewController: BusinessViewController(),
                                      title: "Business".localized,
                                      image: UIImage(systemName: "briefcase") ?? UIImage.add),
            setupNavigationController(rootViewController: TehnologyViewController(),
                                      title: "Tehnology".localized,
                                      image: UIImage(systemName: "gyroscope") ?? UIImage.add)
        ]
    }
    
    private func setupNavigationController(rootViewController: UIViewController,
                                           title: String,
                                           image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}