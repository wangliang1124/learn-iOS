//
//  CameraViewController.swift
//  SnapchatMenu
//
//  Created by 王亮 on 2022/6/29.
//

import Foundation
import UIKit
import AVFoundation

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var captureSession: AVCaptureSession?
    var stillImageOutput : AVCapturePhotoOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    var cameraView: UIView = {
       let view = UIView()
        view.frame = UIScreen.main.bounds
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            
            imagePicker.allowsEditing = true
            imagePicker.cameraCaptureMode = .photo
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        
        self.view.addSubview(imagePicker.view)
        self.view.backgroundColor = .darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        let deviceSession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        let backCamera = deviceSession.devices.first!
        // 已经不能再使用了
        // let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        var error : NSError?
        var input: AVCaptureDeviceInput!

        do {
            input = try AVCaptureDeviceInput(device: backCamera) }
        catch let error1 as NSError {
            error = error1
            input = nil
        }

        if (error == nil && captureSession?.canAddInput(input) != nil) {

            captureSession?.addInput(input)
            stillImageOutput = AVCapturePhotoOutput()
//            stillImageOutput? = [AVVideoCodecKey : AVVideoCodecJPEG]

            if let stillImageOutputTemp = stillImageOutput {
                if captureSession?.canAddOutput(stillImageOutputTemp) != nil {
                    captureSession?.addOutput(stillImageOutputTemp)
                    if let captureSessionTemp = captureSession {
                        previewLayer = AVCaptureVideoPreviewLayer(session: captureSessionTemp)
                        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
                        // 已经废弃不用了
                        // previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                        previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                        cameraView.layer.addSublayer(previewLayer!)
                        captureSession?.startRunning()
                    }
                }
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          
          previewLayer?.frame = cameraView.bounds
      }
      
}
