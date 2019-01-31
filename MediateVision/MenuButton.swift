//
//  MenuButton.swift
//  MediateVision
//
//  Created by Celik, Ercan on 31.01.2019.
//  Copyright © 2019 Celik, Ercan. All rights reserved.
//

import Foundation
import UIKit

class ButtonAsset {
    var image : UIImage?
    var text : String?
    
    init(image: UIImage?, text: String?) {
        self.image = image
        self.text = text
    }
}

class ButtonMetaData {
    var buttonAssets : [ButtonAsset]?
    var visibleButtonCount: Int?
    
    init(buttonAssets : [ButtonAsset]?, visibleButtonCount: Int?) {
        self.buttonAssets = buttonAssets
        self.visibleButtonCount = visibleButtonCount
    }
}

class MenuButton: UIButton {
    let maxImageRatio = CGFloat(0.6)
    let imageOffset = CGFloat(20)
    var maxImageSize : CGSize?
    
    init(frame: CGRect, title: String, icon: UIImage) {
        super.init(frame: frame)
        
        self.maxImageSize = CGSize(width: self.frame.width * maxImageRatio,
                                   height: self.frame.height * maxImageRatio)
        
        
        let iconView = self.createImageView(icon)
        self.addSubview(iconView)
        
        let titleLabel = self.createLabel(title)
        self.addSubview(titleLabel)
    }
    
    private func createImageView(_ icon: UIImage) -> UIImageView {
        let iconView = UIImageView(image: icon)
        self.resizeImage(iconView, iconSize: icon.size)
        
        return iconView
    }
    
    private func resizeImage(_ iconView:UIImageView, iconSize: CGSize){
        var iconViewSize : CGSize?
        
        iconViewSize = CGSize(
            width: iconSize.width * ((self.maxImageSize?.height)! / iconSize.height),
            height: (self.maxImageSize?.height)!
        )
        
        if (iconViewSize?.width)! > (self.maxImageSize?.width)! {
            iconViewSize?.width = (self.maxImageSize?.width)!
        }
        
        iconView.frame.size = iconViewSize!
        iconView.center.y = self.frame.height/2
        iconView.frame.origin.y = imageOffset
        iconView.frame.origin.x = (self.frame.width - iconView.frame.width) / 2
    }
    
    private func createLabel(_ title: String) -> UILabel{
        let titleLabel = UILabel()
        
        titleLabel.text = title
        titleLabel.frame.size.width = self.frame.width
        titleLabel.frame.size.height = 20
        titleLabel.frame.origin.x = 0
        titleLabel.frame.origin.y = self.maxImageSize!.height + imageOffset
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
        return titleLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
