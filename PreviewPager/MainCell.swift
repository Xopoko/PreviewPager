//
//  MainCell.swift
//  PreviewPager
//
//  Created by admin on 20.06.17.
//  Copyright © 2017 horoko. All rights reserved.
//

import UIKit

class MainImageCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    var image = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    let selectionView = UIView()
    var currentPage = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        
        selectionView.isHidden = true
        selectionView.backgroundColor = .white
        selectionView.alpha = 0.4
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        selectionView.layer.borderColor = UIColor.blue.cgColor
        selectionView.layer.borderWidth = 1
        selectionView.layer.masksToBounds = true
        self.addSubview(selectionView)
        self.addConstraint(NSLayoutConstraint(item: selectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: selectionView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: selectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: selectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    override var isSelected: Bool {
        didSet {
            selectionView.isHidden = !isSelected
        }
    }
    
}

