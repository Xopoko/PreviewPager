//
//  PreviewPager.swift
//  PreviewPager
//
//  Created by admin on 20.06.17.
//  Copyright © 2017 horoko. All rights reserved.
//

import UIKit

protocol PreviewPagerDelegate {
    func previewPagerMain(_ scrollView: UIScrollView)
    func previewPagerPreview(_ scrollView: UIScrollView)
    func previewPagerMain(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func previewPagerDPreview(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    
}

protocol PreviewPagerDataSource {
    func previewPagerMain(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    func previewPagerPreview(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    func previewPagerMain(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    func previewPagerPreview(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
}

class PreviewPager: UIView {
    
    fileprivate let mainFlowLayout = UICollectionViewFlowLayout()
    fileprivate let presentFlowLayout = UICollectionViewFlowLayout()
    var images: [UIImage] = []
    var delegate: PreviewPagerDelegate?
    var dataSource: PreviewPagerDataSource?
    
    var mainCurrentPage = 0 {
        didSet {
            previewCollection?.selectItem(at: IndexPath(item: mainCurrentPage, section: 0), animated: true, scrollPosition: .left)
        }
    }
    var mainCollection: UICollectionView? {
        didSet {
            mainCollection?.delegate = self
            mainCollection?.dataSource = self
            mainCollection?.register(MainImageCell.self, forCellWithReuseIdentifier: "mainCell")
            mainCollection?.isPagingEnabled = true
            mainCollection?.showsHorizontalScrollIndicator = false
            mainCollection?.backgroundColor = .clear
        }
    }
    
    var previewCollection: UICollectionView? {
        didSet {
            previewCollection?.delegate = self
            previewCollection?.dataSource = self
            previewCollection?.register(MainImageCell.self, forCellWithReuseIdentifier: "presentCell")
            previewCollection?.showsHorizontalScrollIndicator = false
            previewCollection?.backgroundColor = .clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainCollection = UICollectionView(frame: CGRect(), collectionViewLayout: mainFlowLayout)
        previewCollection = UICollectionView(frame: CGRect(), collectionViewLayout: presentFlowLayout)
        
        
        mainFlowLayout.scrollDirection = .horizontal
        mainFlowLayout.minimumLineSpacing = 5
        presentFlowLayout.scrollDirection = .horizontal
        presentFlowLayout.minimumLineSpacing = 5
        presentFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        self.addSubview(mainCollection!)
        self.addSubview(previewCollection!)
        
        //self.translatesAutoresizingMaskIntoConstraints = false
        mainCollection?.translatesAutoresizingMaskIntoConstraints = false
        previewCollection?.translatesAutoresizingMaskIntoConstraints = false
        
        let mainLeft = NSLayoutConstraint(item: mainCollection!, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let mainTop = NSLayoutConstraint(item: mainCollection!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let mainRight = NSLayoutConstraint(item: mainCollection!, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        let mainHeight = NSLayoutConstraint(item: mainCollection!, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0)
        
        let presentLeft = NSLayoutConstraint(item: previewCollection!, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let presentTop = NSLayoutConstraint(item: previewCollection!, attribute: .top, relatedBy: .equal, toItem: mainCollection, attribute: .bottom, multiplier: 1, constant: 0)
        let presentBottom = NSLayoutConstraint(item: previewCollection!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let presentRight = NSLayoutConstraint(item: previewCollection!, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        
        self.addConstraints([mainLeft, mainTop, mainRight, mainHeight, presentLeft, presentTop, presentBottom, presentRight])
    }
    
}

extension PreviewPager: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = collectionView == mainCollection ? "mainCell" : "presentCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MainImageCell
        cell.image = images[indexPath.row]
        cell.currentPage = mainCurrentPage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let mainWidth = self.frame.width - mainFlowLayout.minimumLineSpacing
        let size = collectionView == mainCollection ? CGSize(width: mainWidth, height: 200) : CGSize(width: 50, height: 50)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != mainCollection {
            mainCollection?.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainCollection {
            let currentPage = scrollView.getCurentPage()
            if currentPage != mainCurrentPage {
                mainCurrentPage = currentPage
            }
        }
    }
}

extension UIScrollView {
    func getCurentPage() -> Int {
        let width = self.frame.size.width
        let page = (self.contentOffset.x + (0.5 * width)) / width
        return Int(page)
    }
}

    
