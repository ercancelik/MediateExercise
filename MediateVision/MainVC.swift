//
//  MainVC.swift
//  MediateVision
//
//  Created by Celik, Ercan on 29.01.2019.
//  Copyright © 2019 Celik, Ercan. All rights reserved.
//

import UIKit

class MainVC: UIViewController{
    
    var menuScrollView : MenuScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonMetaData = ButtonMetaData(buttonAssets: [
                                                ButtonAsset(image: UIImage(named: "voice"), text: "voice"),
                                                ButtonAsset(image: UIImage(named: "person"), text: "person"),
                                                ButtonAsset(image: UIImage(named: "seat"), text: "seat"),
                                                ButtonAsset(image: UIImage(named: "door"), text: "door"),
                                                ButtonAsset(image: UIImage(named: "stairs"), text: "stairs"),
                                                ButtonAsset(image: UIImage(named: "trashcan"), text: "trashcan"),
                                                ButtonAsset(image: UIImage(named: "table"), text: "table"),
                                                ButtonAsset(image: UIImage(named: "elevator"), text: "elevator")
                                                ],
                                            visibleButtonCount:4
        )
        
        self.menuScrollView = MenuScrollView(buttonMetaData: buttonMetaData)
        
        self.view.addSubview(self.menuScrollView!)
        
        self.setupScrollViewAnchors()
    }
    
    private func setupScrollViewAnchors(){
        self.menuScrollView!.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.menuScrollView!.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.menuScrollView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.menuScrollView!.heightAnchor.constraint(equalToConstant: self.menuScrollView!.contentSize.height).isActive = true
    }
}
