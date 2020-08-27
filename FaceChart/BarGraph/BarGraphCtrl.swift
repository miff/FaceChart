//
//  BarGraphCtrl.swift
//  FaceChart
//
//  Created by Milan Djordjevic on 8/27/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import Charts
import UIKit

class BarGraphCtrl: UIViewController {

    lazy var cview: BarChartView = {
        let v = BarChartView()
        return v
    }()
    
    lazy var slider: UISlider = {
        let s = UISlider()
        s.minimumValue = 1
        s.maximumValue = 10
        s.value = 3
        s.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return s
    }()
    
    let service: BarGraphService
    
    init(with service: BarGraphService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        cview.data = service.getData(of: 3)
    }
    
    func setupViews() {
        [cview, slider].forEach(view.addSubview)
        cview.fillSuperview(.init(top: 0, left: 0, bottom: 50, right: 0))
        
        slider.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    @objc
    func handleSliderChange(_ sender: UISlider) {
        cview.data = service.getData(of: Int(sender.value))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
