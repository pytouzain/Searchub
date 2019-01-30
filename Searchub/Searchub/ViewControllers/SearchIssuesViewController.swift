//
//  SearchIssuesViewController.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 14/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

class SearchIssuesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: SearchIssuesViewModel = SearchIssuesViewModel()

    var isSearching: Bool {
        return !(searchBar.text ?? "").isEmpty || searchBar.isFirstResponder
    }
    
    lazy var loadStatusView: LoadStatusView = {
        let view = LoadStatusView(frame: CGRect.zero)
        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.triggerVerticalOffset = Constants.Refresh.verticalOffset
        refreshControl.addTarget(self, action: #selector(loadMoreContent), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleView()
        setupTableView()
        view.addSubview(loadStatusView)
        loadStatusView.loadStatus = .initial
        viewModel.initialUrlSetup()
        loadStatusView.loadStatus = .loading
        viewModel.searchIssues(success: {
            self.loadStatusView.loadStatus = self.viewModel.filteredIssues.count > 0 ? .resultsFounded : .noResult(message: "No issue founded")
            self.tableView.reloadData()
        }) {
            self.loadStatusView.loadStatus = .error(
                message: "An error occured while loading issues",
                isDismissButtonShown: false
            )
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loadStatusView.frame = tableView.frame
    }
    
    private func setupTableView() {
        tableView.bottomRefreshControl = refreshControl
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        IssueCell.register(in: tableView)
    }
    
    private func setupTitleView() {
        let isssueStateSelectorView = IssueStateSelector(frame: CGRect.zero)
        isssueStateSelectorView.delegate = self
        navigationItem.titleView = isssueStateSelectorView
    }
}

extension SearchIssuesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredIssues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = IssueCell.dequeue(from: tableView, for: indexPath)
        let issue = viewModel.filteredIssues[indexPath.row]
        cell.configure(issue: issue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let commentsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        commentsViewController.viewModel.issue = viewModel.filteredIssues[indexPath.row]
        navigationController?.pushViewController(commentsViewController, animated: true)
    }
}

extension SearchIssuesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            viewModel.resetSearch {
                tableView.reloadData()
            }
            return
        }
        viewModel.filterIssues(searchText) {
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SearchIssuesViewController {
    
    @objc func loadMoreContent() {
        viewModel.searchIssues(success: {
            self.tableView.reloadData()
            self.tableView.bottomRefreshControl?.endRefreshing()
        }) {
            self.loadStatusView.loadStatus = .error(
                message: "An error occured while loading more issues",
                isDismissButtonShown: true
            )
            self.tableView.bottomRefreshControl?.endRefreshing()
        }
    }
}

extension SearchIssuesViewController: UIScrollViewDelegate {
    
    /*
     Trigger keyboard if the user is searching and reach the top of the TableView
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 && isSearching {
            searchBar.becomeFirstResponder()
        }
    }
    
    /*
     Hide keyboard when the user starts to scroll downward for a better UX experience
     */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if (actualPosition.y < 0) {
            searchBar.resignFirstResponder()
        }
        tableView.bottomRefreshControl = isSearching ? nil : refreshControl
    }
}

extension SearchIssuesViewController: IssueStateSelectorDelegate {
    func allSelected() {
        viewModel.filterByState(.all) {
            self.loadStatusView.loadStatus = self.viewModel.filteredIssues.count > 0 ? .resultsFounded : .noResult(message: "No issue founded")
            tableView.reloadData()
        }
    }
    
    func openSelected() {
        viewModel.filterByState(.open) {
            self.loadStatusView.loadStatus = self.viewModel.filteredIssues.count > 0 ? .resultsFounded : .noResult(message: "No issue founded")
            tableView.reloadData()
        }
    }
    
    func closedSelected() {
        viewModel.filterByState(.closed) {
            self.loadStatusView.loadStatus = self.viewModel.filteredIssues.count > 0 ? .resultsFounded : .noResult(message: "No issue founded")
            tableView.reloadData()
        }
    }
}
