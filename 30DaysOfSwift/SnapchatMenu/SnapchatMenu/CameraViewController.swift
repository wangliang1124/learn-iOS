//
//  CameraViewController.swift
//  SnapchatMenu
//
//  Created by 王亮 on 2022/6/29.
//

import AVFoundation
import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {
    var captureSession: AVCaptureSession!

    var stillImageOutput: AVCapturePhotoOutput?

    var cameraView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            imagePicker.sourceType = .camera
//
//            imagePicker.allowsEditing = true
//            imagePicker.cameraCaptureMode = .photo
//        } else {
//            imagePicker.sourceType = .photoLibrary
//        }

        let captureBtn = UIButton()
        captureBtn.setImage(UIImage(named: "takePhoto"), for: .normal)
        captureBtn.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
 
        captureBtn.frame.size = CGSize(width: 48, height: 48)
        captureBtn.center.x = view.center.x
        captureBtn.frame.origin.y = view.frame.height - 100

        view.addSubview(cameraView)
        view.addSubview(captureBtn)
        view.backgroundColor = .darkGray
        
        startCaptureSession()
    }

    func startCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo // AVCaptureSession.Preset.hd1920x1080
        //        let deviceSession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)

        //        guard let backCamera = deviceSession.devices.first else {
        //            return
        //        }

        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return
        }

        // 已经不能再使用了
        // let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        var error: NSError?
        var input: AVCaptureDeviceInput!

        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let err as NSError {
            error = err
            input = nil
        }

        if error == nil && captureSession.canAddInput(input) {
            captureSession.addInput(input)

            stillImageOutput = AVCapturePhotoOutput()

            if let stillImageOutput = stillImageOutput, captureSession.canAddOutput(stillImageOutput) {
                captureSession.addOutput(stillImageOutput)

                let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer.frame = cameraView.bounds
                previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait

                cameraView.layer.addSublayer(previewLayer)

                captureSession.startRunning()
            }
        }
    }

    @objc func takePhoto(_ sender: Any) {
        DispatchQueue.main.async { [unowned self] in
            self.view.layer.opacity = 0
            UIView.animate(withDuration: 0.25) { [unowned self] in
                self.view.layer.opacity = 1
            }
        }

        let settingsForMonitoring = AVCapturePhotoSettings()
        settingsForMonitoring.flashMode = .auto
//        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        stillImageOutput?.capturePhoto(with: settingsForMonitoring, delegate: self)
    }

 
    // delegate
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let photoSampleBuffer = photoSampleBuffer {
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
            let image = UIImage(data: photoData!)
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
    }
}
