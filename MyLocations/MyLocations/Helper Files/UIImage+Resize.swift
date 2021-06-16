//
//  UIImage+Resize.swift
//  MyLocations
//
//  Created by Александр Воробьев on 06.05.2021.
//

import UIKit

extension UIImage {
    
    func resized(withBounds bounds: CGSize) -> UIImage {
        let horizontalRatio = bounds.width / size.width
        let verticalRatio = bounds.height / size.height
        let ratio = max(horizontalRatio, verticalRatio)
        let newWidth = size.width * ratio
        let newHeight = size.height * ratio
        UIGraphicsBeginImageContextWithOptions(CGSize(width: bounds.width, height: bounds.height), true, 0)
        draw(in: CGRect(x: (bounds.width - newWidth)/2, y: (bounds.height - newHeight)/2, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
