//
//  DetailCoordinator.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 30/11/20.
//
import UIKit

class DetailCoordinator: Coordinator {
    private var presenter: UINavigationController
    private var url: URL?

    init(presenter: UINavigationController, url: URL) {
        self.presenter = presenter
        self.url = url
        self.presenter.navigationBar.backItem?.title = ""
    }
    
    func start() {
        let viewController = DetailViewController()
        viewController.delegate = self
        viewController.viewModel.url = url
        self.presenter.pushViewController(viewController, animated: true)
    }
    
    func popView() {
        self.presenter.popViewController(animated: false)
    }
}

extension DetailCoordinator: DetailViewControllerDelegate {
    func goBack() {
        self.presenter.popViewController(animated: false)
    }
}
