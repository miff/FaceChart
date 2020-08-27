//
//  DashboardCtrl.swift
//  FaceChart
//
//  Created by Milan Djordjevic on 8/27/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import UIKit

class DashboardCtrl: UIViewController {
    
    lazy var pieBox: UIView = {
        let v = UIView()
        addToview(to: v, child: pieVC)
        return v
    }()
    
    lazy var barBox: UIView = {
        let v = UIView()
        addToview(to: v, child: barVC)
        return v
    }()
    
    lazy var camBox: UIView = {
        let v = UIView()
        addToview(to: v, child: cameraVC)
        return v
    }()
    
    let pieVC = PieCtrl(with: PieService())
    let barVC = BarGraphCtrl(with: BarGraphService())
    let cameraVC = CameraCtrl()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
    }

    func setupViews() {
        let w: CGFloat = view.frame.width / 3 - 32
        [pieBox, barBox, camBox].forEach(view.addSubview)
        
        pieBox.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,
                      padding: .init(top: 64, left: 32, bottom: 0, right: 0),
                      size: .init(width: w, height: w))
        
        barBox.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: pieBox.trailingAnchor, bottom: nil, trailing: nil,
                      padding: .init(top: 64, left: 2, bottom: 0, right: 0),
                      size: .init(width: w, height: w))
        
        camBox.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: barBox.trailingAnchor, bottom: nil, trailing: nil,
                      padding: .init(top: 64, left: 16, bottom: 0, right: 0),
                      size: .init(width: w, height: w))
    }

}
