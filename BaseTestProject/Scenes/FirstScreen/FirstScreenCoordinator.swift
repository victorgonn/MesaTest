//
//  FirstScreenCoordinator.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 01/12/20.
//

import Foundation
import UIKit

class FirstScreenCoordinator: Coordinator {
    private var presenter: UINavigationController

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.presenter.navigationBar.backItem?.title = ""
    }
    
    func start() {
        let viewController = FirstScreenViewController()
        viewController.delegate = self
        self.presenter.pushViewController(viewController, animated: true)
    }
    
    func popView() {
        self.presenter.popViewController(animated: false)
    }
}

extension FirstScreenCoordinator: FirstScreenViewControllerDelegate {
    func navigateToSingUp() {
        let coordinator = SingUpViewCoordinator(presenter: self.presenter)
        coordinator.start()
    }
    
    func navigateToLogin() {
        let coordinator = LoginCoordinator(presenter: self.presenter)
        coordinator.start()
    }
    
    func navigateToHome() {
        let coordinator = HomeCoordinator(presenter: self.presenter)
        coordinator.start()
    }
}
