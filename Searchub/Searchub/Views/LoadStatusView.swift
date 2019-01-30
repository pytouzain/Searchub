//
//  LoadStatusView.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 18/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

enum LoadStatus {
    case initial
    case loading
    case resultsFounded
    case noResult(message: String)
    case error(message: String, isDismissButtonShown: Bool)
}

class LoadStatusView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    var loadStatus: LoadStatus = .initial {
        didSet {
            switch loadStatus {
            case .initial:
                stopLoader()
                showDismissButton(false)
                appear()
                setMessageStatus("")
            case .loading:
                startLoader()
                appear()
                setMessageStatus("Sit back and relax, your content is being loaded")
            case .resultsFounded:
                disappear()
                stopLoader()
            case .noResult(let message):
                stopLoader()
                appear()
                setMessageStatus(message)
            case .error(let message, let isDismissButtonShown):
                stopLoader()
                appear()
                setMessageStatus(message)
                showDismissButton(isDismissButtonShown)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(Constants.Xib.loadStatusView, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func startLoader() {
        loader.isHidden = false
        loader.startAnimating()
    }
    
    private func stopLoader() {
        loader.stopAnimating()
        loader.isHidden = true
    }
    
    private func appear() {
        isHidden = false
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1.0
        }
    }
    
    private func disappear() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.0
        }) { _ in
            self.isHidden = true
        }
    }
    
    private func setMessageStatus(_ message: String) {
        statusLabel.text = message
    }
    
    private func showDismissButton(_ isShown: Bool) {
        dismissButton.isHidden = !isShown
    }
}

extension LoadStatusView {
    
    @IBAction func dismissAction() {
        disappear()
    }
    
}
