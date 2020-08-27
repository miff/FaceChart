//
//  CameraView.swift
//  FaceChart
//
//  Created by Milan Djordjevic on 8/27/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import AVFoundation
import UIKit

protocol CameraViewDelegate {
    func onImageCreated(_ image: UIImage)
}

final class CameraView: UIView {
    
    var statusBarOrientation: UIInterfaceOrientation {
        get {
            guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {
                return .portrait
            }
            return orientation
        }
    }
    
    private lazy var videoDataOutput: AVCaptureVideoDataOutput = {
        let v = AVCaptureVideoDataOutput()
        v.alwaysDiscardsLateVideoFrames = true
        v.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        v.connection(with: .video)?.isEnabled = true
        return v
    }()
    
    private let videoDataOutputQueue: DispatchQueue = DispatchQueue(label: "VideoDataOutputQueue")
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let l = AVCaptureVideoPreviewLayer(session: session)
        l.videoGravity = .resizeAspectFill
        if let _ = l.connection?.isVideoOrientationSupported {
            l.connection?.videoOrientation = statusBarOrientation.isLandscape ? .landscapeLeft : .portrait
        }
        return l
    }()
    
    private let captureDevice: AVCaptureDevice? = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    
    private lazy var session: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = .high
        return s
    }()
    
    private lazy var capturePhotoOutput: AVCapturePhotoOutput = {
        let v = AVCapturePhotoOutput()
        v.isHighResolutionCaptureEnabled = true
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentMode = .scaleAspectFill
        beginSession()
    }
    
    public var delegate: CameraViewDelegate!
    
    private func beginSession() {
        do {
            guard let captureDevice = captureDevice else {
                print("Camera doesn't work on the simulator! You have to test this on an actual device!")
                return
            }
            
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            if session.canAddInput(deviceInput) {
                session.addInput(deviceInput)
            }
            
            if session.canAddOutput(videoDataOutput) {
                session.addOutput(videoDataOutput)
                session.addOutput(capturePhotoOutput)
            }
            layer.masksToBounds = true
            layer.addSublayer(previewLayer)
            previewLayer.frame = bounds
            session.startRunning()
        } catch let error {
            debugPrint("\(self.self): \(#function) line: \(#line).  \(error.localizedDescription)")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer.frame = bounds
    }
}

extension CameraView: AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let imageData = photo.fileDataRepresentation()
        if let data = imageData, let img = UIImage(data: data) {
            if delegate != nil { delegate.onImageCreated(img) }
        }
    }
    
    func takePhoto() {
        
        guard let _ = captureDevice else {
            if delegate != nil { delegate.onImageCreated(UIImage(named: "Dummy")!) }
            return
        }
        
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
}


extension UIInterfaceOrientation {
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeRight: return .landscapeRight
        case .landscapeLeft: return .landscapeLeft
        case .portrait: return .portrait
        default: return nil
        }
    }
}

