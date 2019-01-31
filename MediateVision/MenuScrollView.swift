//
//  MenuScrollView.swift
//  MediateVision
//
//  Created by Celik, Ercan on 31.01.2019.
//  Copyright © 2019 Celik, Ercan. All rights reserved.
//

import Foundation
import UIKit

class MenuScrollView : UIScrollView {
    
    init(buttonMetaData: ButtonMetaData?){
        super.init(frame: CGRect())
        
        let spaceButtonCount = (buttonMetaData?.visibleButtonCount)! / 2
        let screenSize = UIScreen.main.bounds
        
        let buttonWidth : CGFloat = screenSize.width / CGFloat((buttonMetaData?.visibleButtonCount)! + spaceButtonCount)
        let buttonHeight : CGFloat = buttonWidth
        let buttonSize = CGSize(width:buttonWidth, height:buttonHeight)
        let space = (CGFloat(spaceButtonCount) * buttonWidth) / CGFloat((buttonMetaData?.visibleButtonCount)!)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentSize.height = buttonHeight
        self.contentSize.width = buttonWidth * CGFloat((buttonMetaData?.buttonAssets)!.count) + space * CGFloat((buttonMetaData?.buttonAssets)!.count)
        
        self.backgroundColor = UIColor.yellow
        
        for (index, item) in (buttonMetaData?.buttonAssets)!.enumerated() {
            
            let button = MenuButton(frame: CGRect(origin: CGPoint(x: space / 2 + CGFloat(index) * buttonWidth + CGFloat(index) * space, y: 0),
                                                  size: buttonSize),
                                    title: item.text!,
                                    icon: item.image!,
                                    imageFitStrategy: (buttonMetaData?.imageFitStrategy)!)
            
            self.addSubview(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
