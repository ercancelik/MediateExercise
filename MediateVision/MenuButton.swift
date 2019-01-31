//
//  MenuButton.swift
//  MediateVision
//
//  Created by Celik, Ercan on 31.01.2019.
//  Copyright © 2019 Celik, Ercan. All rights reserved.
//

import Foundation
import UIKit

enum ImageFitStrategy {
    case ratio
    case stretch
}

class ButtonAsset {
    var image : UIImage?
    var text : String?
    
    init(image: UIImage?, text: String?) {
        self.image = image
        self.text = text
    }
}

class ButtonMetaData {
    var imageFitStrategy : ImageFitStrategy? = .ratio
    var buttonAssets : [ButtonAsset]?
    var visibleButtonCount: Int?
    
    init(imageFitStrategy: ImageFitStrategy?, buttonAssets : [ButtonAsset]?, visibleButtonCount: Int?) {
        self.imageFitStrategy = imageFitStrategy
        self.buttonAssets = buttonAssets
        self.visibleButtonCount = visibleButtonCount
    }
}

class MenuButton: UIButton {
    var imageFitStrategy : ImageFitStrategy? = .ratio
    let maxImageRatio = CGFloat(0.7)
    var maxImageSize : CGSize?
    
    var iconView : UIImageView?
    
    init(frame: CGRect, title: String, icon: UIImage, imageFitStrategy:ImageFitStrategy) {
        super.init(frame: frame)
        self.imageFitStrategy = imageFitStrategy
        
        self.maxImageSize = CGSize(width: self.frame.width * maxImageRatio, height: self.frame.height * maxImageRatio)
        
        self.backgroundColor = .white
        
        self.iconView = UIImageView(image: icon)
        self.resizeImage(iconSize: icon.size)
        self.addSubview(self.iconView!)
        
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.frame.size.width = self.frame.width
        titleLabel.frame.size.height = 20
        titleLabel.frame.origin.x = 0
        titleLabel.frame.origin.y = self.frame.height - titleLabel.frame.size.height
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        self.addSubview(titleLabel)
    }
    
    private func resizeImage(iconSize: CGSize){
        var iconViewSize : CGSize?
        if self.imageFitStrategy == .ratio {
            iconViewSize = self.calculateSizeAccordingToRatio(iconSize: iconSize)
        } else {
            iconViewSize = self.calculateSizeByStretching(iconSize: iconSize)
        }
        
        self.iconView!.frame.size = iconViewSize!
        self.iconView!.center.y = self.frame.height/2
        self.iconView!.frame.origin.y = 0
        self.iconView!.frame.origin.x = (self.frame.width - self.iconView!.frame.width) / 2
    }
    
    private func calculateSizeAccordingToRatio(iconSize: CGSize) -> CGSize? {
        var iconViewSize : CGSize?
        
        if iconSize.width < (self.maxImageSize?.width)! &&
            iconSize.height < (self.maxImageSize?.height)! {
            let widthRatio = (self.maxImageSize?.width)! / iconSize.width
            let heightRatio = (self.maxImageSize?.height)! / iconSize.height
            
            if widthRatio < heightRatio {
                iconViewSize = CGSize(width: (self.maxImageSize?.width)!,
                                      height: iconSize.height * widthRatio)
                
            } else {
                iconViewSize = CGSize(width: iconSize.width * heightRatio,
                                      height: (self.maxImageSize?.height)!)
            }
        } else if iconSize.width > (self.maxImageSize?.width)! &&
            iconSize.height > (self.maxImageSize?.height)! {
            let widthRatio = iconSize.width / (self.maxImageSize?.width)!
            let heightRatio = iconSize.height / (self.maxImageSize?.height)!
            
            if widthRatio < heightRatio {
                iconViewSize = CGSize(width: iconSize.width / heightRatio,
                                      height: (self.maxImageSize?.height)!)
                
            } else {
                iconViewSize = CGSize(width: (self.maxImageSize?.width)!,
                                      height: iconSize.height / widthRatio)
            }
            
        } else {
            if iconSize.width > (self.maxImageSize?.width)! {
                iconViewSize = CGSize(width: (self.maxImageSize?.width)!,
                                      height: (self.maxImageSize?.height)! / (iconSize.width / (self.maxImageSize?.width)!))
            } else {
                iconViewSize = CGSize(width: (self.maxImageSize?.width)! / (iconSize.height / (self.maxImageSize?.height)!),
                                      height: (self.maxImageSize?.height)!)
            }
        }
        
        return iconViewSize
    }
    
    private func calculateSizeByStretching(iconSize: CGSize) -> CGSize? {
        return self.maxImageSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
