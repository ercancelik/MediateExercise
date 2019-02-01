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
    
    init(buttonMetaData: ButtonMetaData?, height: CGFloat){
        super.init(frame: CGRect())
        
        self.backgroundColor = .white
        
        let screenSize = UIScreen.main.bounds
        
        self.contentSize.height = height
        
        let buttonWidth = screenSize.width / CGFloat((buttonMetaData?.visibleButtonCount)!)
        let buttonHeight = self.contentSize.height
        let buttonSize = CGSize(width:buttonWidth, height:buttonHeight)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentSize.width = buttonWidth * CGFloat((buttonMetaData?.buttonAssets)!.count)
                
        for (index, item) in (buttonMetaData?.buttonAssets)!.enumerated() {
            
            let button = MenuButton(frame: CGRect(origin: CGPoint(x: CGFloat(index) * buttonWidth, y: 0),
                                                  size: buttonSize),
                                    title: item.text!,
                                    icon: item.image!)
            
            self.addSubview(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
