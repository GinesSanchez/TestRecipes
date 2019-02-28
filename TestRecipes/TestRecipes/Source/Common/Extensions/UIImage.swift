//
//  UIImage.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

extension UIImage {

    public func resize(newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {

        let newSize = CGSize(width: newWidth,  height: newHeight)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
