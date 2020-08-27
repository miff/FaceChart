//
//  CamerCtrl.swift
//  FaceChart
//
//  Created by Milan Djordjevic on 8/27/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import UIKit

class CameraCtrl: UIViewController {
    
    lazy var imgPreview: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        i.backgroundColor = .black
        i.isHidden = true
        return i
    }()
    
    lazy var cameraView: CameraView = {
        let c = CameraView()
        c.backgroundColor = .black
        c.delegate = self
        return c
    }()
    
    lazy var cameraBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = .gray
        b.setTitle("Capture", for: .normal)
        b.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
        return b
    }()
    
    lazy var cancelBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = .lightGray
        b.setTitle("Cancel", for: .normal)
        b.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @objc
    func handleCamera(_ sender: UIButton) {
        cameraView.takePhoto()
    }
    
    @objc
    func handleCancel(_ sender: UIButton) {
        imgPreview.image = nil
        imgPreview.isHidden = true
    }
    
    func setupViews() {
        [cameraView, imgPreview, cameraBtn, cancelBtn].forEach(view.addSubview)
        
        cameraView.fillSuperview(.init(top: 0, left: 0, bottom: 50, right: 0))
        imgPreview.fillSuperview(.init(top: 0, left: 0, bottom: 50, right: 0))
        
        cameraBtn.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil,
                         padding: .zero,
                         size: .init(width: 100, height: 44))
        
        cancelBtn.anchor(top: nil, leading: nil, bottom: view.bottomAnchor, trailing: view.trailingAnchor,
                         padding: .zero,
                         size: .init(width: 100, height: 44))
    }
}

extension CameraCtrl: CameraViewDelegate {
    func onImageCreated(_ image: UIImage) {
        imgPreview.isHidden = false
        imgPreview.image = image
    }
    
    
}
