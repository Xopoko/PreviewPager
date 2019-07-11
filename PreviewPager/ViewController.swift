//
//  ViewController.swift
//  PreviewPager
//
//  Created by admin on 20.06.17.
//  Copyright © 2017 horoko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        let previewPager = PreviewPager(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        previewPager.images = createImages(count: 10)
        previewPager.center = view.center
        view.addSubview(previewPager)
    }
    
    private func createImages(count: Int) -> [UIImage] {
        var images = [UIImage]()
        for _ in 0..<count {
            images.append(UIImage.withRandomColor())
        }
        return images
    }
}

extension UIImage {
    private static func fromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    private static func getRandomColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    static func withRandomColor() -> UIImage {
        return fromColor(color: getRandomColor())
    }
}

