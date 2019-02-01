//
//  MainVC.swift
//  MediateVision
//
//  Created by Celik, Ercan on 29.01.2019.
//  Copyright © 2019 Celik, Ercan. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController{
    
    let menuHeight = UIScreen.main.bounds.height / 6
    
    var menuScrollView : MenuScrollView?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var bottomConstaint : NSLayoutConstraint!
    @IBOutlet weak var cameraPreview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initMenuView()
        
        self.startCamera()
    }
    
    private func initMenuView() {
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
            visibleButtonCount: 4
        )
        
        self.menuScrollView = MenuScrollView(buttonMetaData: buttonMetaData, height: menuHeight)
        
        self.view.addSubview(self.menuScrollView!)
        
        self.setupScrollViewAnchors()
    }
    
    private func startCamera() {
        let captureSession = AVCaptureSession()
        let cameraOutput = AVCapturePhotoOutput()
        
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back),
            let input = try? AVCaptureDeviceInput(device: device) {
            if (captureSession.canAddInput(input)) {
                captureSession.addInput(input)
                if (captureSession.canAddOutput(cameraOutput)) {
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                    previewLayer?.connection!.videoOrientation = AVCaptureVideoOrientation.portrait
                    previewLayer?.frame = cameraPreview.bounds
                    cameraPreview.layer.addSublayer(previewLayer!)
                    captureSession.startRunning()
                }
            } else {
                print("Couldn't connect to camera")
            }
        } else {
            print("Camera device have problems")
        }
    }
    
    private func setupScrollViewAnchors(){
        self.menuScrollView!.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.menuScrollView!.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.menuScrollView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.menuScrollView!.heightAnchor.constraint(equalToConstant: self.menuScrollView!.contentSize.height).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        self.previewLayer!.frame = self.cameraPreview.bounds
    }
    
    override func updateViewConstraints() {
        self.bottomConstaint.constant = menuHeight
        super.updateViewConstraints()
    }
}
