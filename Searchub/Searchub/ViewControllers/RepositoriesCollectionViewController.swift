//
//  RepositoriesCollectionViewController.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 14/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

class RepositoriesCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: RepositoriesCollectionView!

    lazy var removeConfirmationView: RemoveRepositoryConfirmationView = {
        let removeConfirmationView = RemoveRepositoryConfirmationView(frame: UIScreen.main.bounds)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(removeConfirmationView)
        return removeConfirmationView
    }()
    
    var repositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        repositories = DataManager.shared.getRepositoriesList()
        collectionView.reloadData()
        updateTitle()
    }
    
    private func updateTitle() {
        if repositories.count == 0 {
            title = "Add a repository"
        } else {
            title = "Repositor\(repositories.count == 1 ? "y" : "ies")"
        }
    }
}

extension RepositoriesCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = RepositoryCollectionCell.dequeue(from: collectionView, for: indexPath)
        let repository = repositories[indexPath.row]
        cell.delegate = self
        cell.configure(withRepository: repository, showRemoveButton: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchIssuesViewController: SearchIssuesViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "SearchIssuesViewController") as! SearchIssuesViewController
        searchIssuesViewController.viewModel.repository = repositories[indexPath.row]
        navigationController?.pushViewController(searchIssuesViewController, animated: true)
    }
}

extension RepositoriesCollectionViewController: RepositoryCollectionCellDelegate {
    func removeCell(_ cell: RepositoryCollectionCell) {
        removeConfirmationView.appear()
        removeConfirmationView.removeCompletion = {
            if let indexPath = self.collectionView.indexPath(for: cell) {
                let removedRepository = self.repositories.remove(at: indexPath.row)
                DataManager.shared.deleteRepository(removedRepository)
                self.collectionView.deleteItems(at: [indexPath])
                self.updateTitle()
            }
        }
    }
}
