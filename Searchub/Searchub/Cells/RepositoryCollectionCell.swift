//
//  RepositoryCollectionCell.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 15/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit
import SDWebImage

protocol RepositoryCollectionCellDelegate {
    func removeCell(_ cell: RepositoryCollectionCell)
}

class RepositoryCollectionCell: UICollectionViewCell, Registrable, Dequeable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ownerLoginLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImageView: RoundedImageView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var stargazersCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    var delegate: RepositoryCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 12, *) { setupSelfSizingForiOS12(contentView: contentView) }
        setupConstraints()
    }
    
    /*
     Define the width of the cell. It needs to be precisely calculated in order to get the number
     of columns wanted (for example on bigger layout like iPads)
     */
    private func setupConstraints() {
        let width = UIDevice.current.userInterfaceIdiom == .phone ?
                UIScreen.main.bounds.width - (Constants.Metrics.margin * 2.0) :
                (UIScreen.main.bounds.width - (Constants.Metrics.margin * 3.0)) / 2
        
        widthConstraint.constant = width
    }

    func configure(withRepository repository: Repository, showRemoveButton: Bool = false) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.repoDescription
        ownerLoginLabel.text = repository.owner?.login
        avatarImageView.sd_setImage(with: URL(string: repository.owner?.avatarUrlString ?? ""), completed: nil)
        removeButton.isHidden = !showRemoveButton
        stargazersCountLabel.text = "\(repository.stargazersCount)"
        forkCountLabel.text = "\(repository.forksCount)"
        descriptionLabel.preferredMaxLayoutWidth = widthConstraint.constant - (Constants.Metrics.margin * 2)
    }
    
    @IBAction func removeAction() {
        delegate?.removeCell(self)
    }
}
