//
//  PieCtrl.swift
//  FaceChart
//
//  Created by Milan Djordjevic on 8/27/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import Charts
import UIKit

class PieCtrl: UIViewController {

    lazy var cview: PieChartView = {
        let v = PieChartView()
        v.drawHoleEnabled = false
        return v
    }()
    
    lazy var stepper: UIStepper = {
        let s = UIStepper()
        s.minimumValue = 1
        s.maximumValue = 5
        s.value = 1
        s.addTarget(self, action: #selector(handleStepperChange), for: .valueChanged)
        return s
    }()
    
    let service: PieService
    
    init(with service: PieService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        cview.data = service.getData(of: 1)
    }
    
    func setupViews() {
        [cview, stepper].forEach(view.addSubview)
        cview.fillSuperview(.init(top: 0, left: 0, bottom: 50, right: 0))
        
        stepper.anchor(top: nil, leading: view.centerXAnchor, bottom: view.bottomAnchor, trailing: nil,
                       padding: .init(top: 0, left: -50, bottom: 0, right: 0),
                       size: .init(width: 100, height: 0))
    }
    
    @objc
    func handleStepperChange(_ sender: UIStepper) {
        cview.data = service.getData(of: Int(sender.value))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
