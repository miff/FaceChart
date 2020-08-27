//
//  UIViewController+Extension.swift
//  FaceChart
//
//  Created by Milan Djordjevic on 8/27/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addToview<T: UIViewController>(to v: UIView, child: T) {
        addChild(child)
        child.view.frame = v.frame
        v.addSubview(child.view)
        child.view.fillSuperview()
        child.didMove(toParent: self)
    }
}
