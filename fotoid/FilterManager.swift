//
//  FilterManager.swift
//  fotoid
//
//  Created by Cassia Franco on 31/08/2019.
//  Copyright © 2019 Cassia Franco. All rights reserved.
//

import UIKit
import Foundation

enum FilterType: Int{
    case comic
    case sepia
    case helftone
    case crystallize
    case vignatte
    case noir
}

class FilterManager{
    let originImage: UIImage
    let context = CIContext(options: nil)
    let filterNames = [
    "CIComicEffect",
    "CISepiaTone",
    "CICMYKHalftone",
    "CICrystallize",
    "CIVignette",
    "CIPhotoEffectNoir",
    
    ]
    init (image: UIImage){
        self.originImage = image
    }
    func applyFilter (type: FilterType) -> UIImage{
        let ciImage = CIImage(image: originImage)!
        let filter = CIFilter(name: filterNames[type.hashValue])!
        switch type {
        case .comic:
            break
        case .sepia:
            filter.setValue(1.0, forKey: kCIInputIntensityKey)
        case .helftone:
            filter.setValue(20, forKey: kCIInputWidthKey)
        case .crystallize:
            filter.setValue(25, forKey: kCIInputRadiusKey)
        case .vignatte:
            filter.setValue(3, forKey: kCIInputIntensityKey)
            filter.setValue(30, forKey: kCIInputRadiusKey)
        case .noir:
            break
        }
        let filteredImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
        let cgImage = context.createCGImage(filteredImage, from: filteredImage.extent)
        return UIImage(cgImage: cgImage!)
    }
    
}
