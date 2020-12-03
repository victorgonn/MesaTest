//
//  LoginCoordinator.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 26/11/20.
//

import Foundation
import UIKit
import Promises
import SnapKit

protocol HomeViewControllerDelegate: class {
    func navigateToDetail(url: URL)
}

public class HomeViewController: BaseViewController {
    var hNewsHeaderView: HeaderView!
    var collectionView: UICollectionView!
    
    var newsHeaderView: HeaderView!
    var tableView: UITableView!
    
    var viewModel: HomeViewModel = HomeViewModel()
    var delegate: HomeViewControllerDelegate?
    
    var defaultCellId: String = "DefaultCellId"
    var timerToSearch: Timer?

    public override func loadView() {
        super.loadView()
        hNewsHeaderView = HeaderView()
        hNewsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        hNewsHeaderView.setStyle(title: "Hylighted News", color: UIColor.Theme.primary)
        
        newsHeaderView = HeaderView()
        newsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        newsHeaderView.setStyle(title: "News", color: UIColor.Theme.textColor0)
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = UIColor.Theme.fieldBackground
        
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellId)
        tableView.dataSource = self
        tableView.delegate = self
        
        buildViewHierarchy()
        setupConstraints()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "News"
        getFirstNews()
    }
    
    func getFirstNews() {
        self.showLoading(true)
        all(self.viewModel.getHNews(), self.viewModel.getNews()).then { hResponse, nResponse in
            self.viewModel.hNews = hResponse.data
            self.viewModel.news = nResponse.data
            self.viewModel.maxPage = nResponse.pagination?.total_pages
            self.tableView.reloadData()
            self.showLoading(false)
        }.catch { error in
            self.showLoading(false)
            if let error = error as? ErrorResponse {
                debugPrint("error: ", error.message)
            }
        }

    }
    
    func getMoreNews() {
        debugPrint("carregando news da pagina:", viewModel.pageIndex)
        self.viewModel.getNews().then(on: .main) { response in
            self.viewModel.news.append(contentsOf: response.data)
            self.tableView.reloadData()
        }.catch(on: .main) { error in
            self.showLoading(false)
        }
    }
    
    public func buildViewHierarchy() {
        self.view.addSubview(hNewsHeaderView)
        self.view.addSubview(collectionView)
        self.view.addSubview(newsHeaderView)
        self.view.addSubview(tableView)
    }
    
    public func setupConstraints() {
        hNewsHeaderView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(45)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(hNewsHeaderView.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(120)
        }
        
        newsHeaderView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(45)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(newsHeaderView.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.maxPage != nil ? self.viewModel.news.count : 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellId, for: indexPath)
        let item = self.viewModel.news[indexPath.section]
        cell.backgroundColor = UIColor.random()
        
        if let imgUrl = URL(string: item.image_url) {
            cell.imageView?.load(url: imgUrl)
        }
        
        cell.textLabel?.text = item.description
        cell.textLabel?.font = FontStyle.f14PrimaryRegular.font
        cell.textLabel?.textColor = UIColor.Theme.textColor1
        cell.textLabel?.textAlignment = .left
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.news[indexPath.section]
        if let url = URL(string: item.url) {
            self.delegate?.navigateToDetail(url: url)
        }
        
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let actualIndex = indexPath.section
        if viewModel.pageIndex < viewModel.maxPage ?? 0 , actualIndex >= viewModel.news.count - 20 {
            getMoreNews()
        }
    }
}

