//
//  SingUpViewCoordinator.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 02/12/20.
//

import Foundation
import UIKit

class SingUpViewCoordinator: Coordinator {
    private var presenter: UINavigationController

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.presenter.navigationBar.backItem?.title = ""
    }
    
    func start() {
        let viewController = SingUpViewController()
        viewController.delegate = self
        self.presenter.pushViewController(viewController, animated: true)
    }
    
    func popView() {
        self.presenter.popViewController(animated: false)
    }
}

extension SingUpViewCoordinator: SingUpViewControllerDelegate {
    func navigateToLogin() {
        let coordinator = LoginCoordinator(presenter: self.presenter)
        coordinator.start()
    }
    
    func navigateToHome() {
        let coordinator = HomeCoordinator(presenter: self.presenter)
        coordinator.start()
    }
}
