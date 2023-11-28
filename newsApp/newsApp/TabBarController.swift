//
//  TabBarController.swift
//  newsApp
//
//  Created by User on 27.11.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = .black
        setupViewControllers()
    }
    
    // MARK: Private methods
    private func setupViewControllers() {
        viewControllers = [
            setupNavigationController(rootViewController: GeneralViewController(),
                                      image: UIImage(systemName: "newspaper") ?? UIImage.add,
                                      title: "General"),
            setupNavigationController(rootViewController: BusinessViewController(),
                                      image: UIImage(systemName: "briefcase") ?? UIImage.add,
                                      title: "Business"),
            setupNavigationController(rootViewController: TechnologyViewController(),
                                      image: UIImage(systemName: "gyroscope") ?? UIImage.add,
                                      title: "Technology")
        ]
    }
    
    private func setupNavigationController(rootViewController: UIViewController, 
                                           image: UIImage,
                                           title: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem.title = title.localized
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title.localized
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
