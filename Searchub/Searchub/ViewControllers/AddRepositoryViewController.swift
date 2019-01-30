//
//  AddRepositoryViewController.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 14/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

class AddRepositoryViewController: UIViewController {

    @IBOutlet weak var collectionView: RepositoriesCollectionView!
    
    lazy var loadStatusView: LoadStatusView = {
        let view = LoadStatusView(frame: CGRect.zero)
        return view
    }()
    
    var viewModel: AddRepositoryViewModel = AddRepositoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        view.addSubview(loadStatusView)
        loadStatusView.loadStatus = .initial
        setupBottomRefreshControl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loadStatusView.frame = collectionView.frame
    }
}

extension AddRepositoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = RepositoryCollectionCell.dequeue(from: collectionView, for: indexPath)
        let repository = viewModel.repositories[indexPath.row]
        cell.configure(withRepository: repository)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DataManager.shared.addRepository(viewModel.repositories[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

extension AddRepositoryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.resetSearch()
        loadStatusView.loadStatus = .loading
        viewModel.searchRepositories(query: searchBar.text ?? "", success: {
            self.collectionView.scrollRectToVisible(self.collectionView.bounds, animated: false)
            self.collectionView.reloadData()
            self.loadStatusView.loadStatus = self.viewModel.repositories.count > 0 ? .resultsFounded : .noResult(message: "Unfortunately, there is no result for your search")
        }) {
            self.loadStatusView.loadStatus = .error(
                message: "An error occured while loading potential results",
                isDismissButtonShown: false
            )
        }
    }
}

extension AddRepositoryViewController {
    private func setupBottomRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.triggerVerticalOffset = Constants.Refresh.verticalOffset
        refreshControl.addTarget(self, action: #selector(loadMoreContent), for: .valueChanged)
        collectionView.bottomRefreshControl = refreshControl
    }
    
    @objc func loadMoreContent() {
        guard viewModel.isTotalCountReached() else {
            self.collectionView.bottomRefreshControl?.endRefreshing()
            return
        }
        viewModel.searchRepositories(success: {
            self.collectionView.reloadData()
            self.collectionView.bottomRefreshControl?.endRefreshing()
        }) {
            self.loadStatusView.loadStatus = .error(
                message: "An error occured while loading more potential results",
                isDismissButtonShown: true
            )
            self.collectionView.bottomRefreshControl?.endRefreshing()
        }
    }
}
