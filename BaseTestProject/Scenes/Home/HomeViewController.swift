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
    var collectionCellId: String = "CollectionCellId"
    var timerToSearch: Timer?

    public override func loadView() {
        super.loadView()
        hNewsHeaderView = HeaderView()
        hNewsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        hNewsHeaderView.setStyle(title: "Hylighted News", color: UIColor.Theme.primary)
        
        newsHeaderView = HeaderView()
        newsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        newsHeaderView.setStyle(title: "News", color: UIColor.Theme.textColor0)
        
        let screemSize = UIScreen.main.bounds.size
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize =  CGSize(width: screemSize.width / 2, height: 120)
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.Theme.fieldBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HilightCollectionCell.self, forCellWithReuseIdentifier: collectionCellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: defaultCellId)
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
            self.collectionView.reloadData()
            self.showLoading(false)
        }.catch { error in
            self.showLoading(false)
            if let error = error as? ErrorResponse {
                debugPrint("error: ", error.message)
            }
        }

    }
    
    func getMoreNews() {
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as? HilightCollectionCell {
            let item = self.viewModel.hNews[indexPath.row]
            cell.titleLabel.setStyle(FontStyle.f12PrimaryRegular, text: item.title, color: UIColor.Theme.textColor2, enabledUppercase: false, numeberOfLines: 0, name: "")
            
            if let imgUrl = URL(string: item.image_url) {
                cell.imgView.load(url: imgUrl)
            }
            
            cell.selectedAction = {
                if let url = URL(string: item.url) {
                    self.delegate?.navigateToDetail(url: url)
                }
            }

            return cell
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.hNews.count
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellId, for: indexPath) as? HomeTableViewCell {
            let item = self.viewModel.news[indexPath.section]
            
            cell.titleLabel.setStyle(FontStyle.f12PrimaryRegular, text: item.title, color: UIColor.Theme.textColor0, enabledUppercase: false, numeberOfLines: 0, name: "")
            
            cell.descriptionLabel.setStyle(FontStyle.f12PrimaryRegular, text: item.description, color: UIColor.Theme.textColor0, enabledUppercase: false, numeberOfLines: 0, name: "")
            
            if let imgUrl = URL(string: item.image_url) {
                cell.imgView.load(url: imgUrl)
            }

            cell.selectedAction = {
                if let url = URL(string: item.url) {
                    self.delegate?.navigateToDetail(url: url)
                }
            }
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: defaultCellId, for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let actualIndex = indexPath.section
        if viewModel.pageIndex < viewModel.maxPage ?? 0 , actualIndex >= viewModel.news.count - 20 {
            getMoreNews()
        }
    }
}

