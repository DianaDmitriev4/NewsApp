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
        setupTabBar()
    }
    
    // MARK: Private methods
    private func setupViewControllers() {
        viewControllers = [
            setupNavigationController(rootViewController: GeneralViewController(viewModel: GeneralViewModel()),
                                      image: UIImage(systemName: "newspaper") ?? UIImage.add,
                                      title: "General"),
            setupNavigationController(rootViewController: BusinessViewController(viewModel: BusinessViewModel()),
                                      image: UIImage(systemName: "briefcase") ?? UIImage.add,
                                      title: "Business"),
            setupNavigationController(rootViewController: TechnologyViewController(viewModel: TechnologyViewModel()),
                                      image: UIImage(systemName: "gyroscope") ?? UIImage.add,
                                      title: "Technology")
        ]
    }
    
    private func setupNavigationController(rootViewController: UIViewController, 
                                           image: UIImage,
                                           title: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
    
    private func setupTabBar() {
    let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.scrollEdgeAppearance = appearance
        view.tintColor = .black
    }
}
