//
//  PieService.swift
//  FaceChart
//
//  Created by Milan Djordjevic on 8/27/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import Charts
import Foundation


class PieService {
    
    init() {}
    static let shared = PieService()
    
    func getData(of bounds: Int = 3) -> PieChartData {
        let e = (0..<bounds).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double.random(in: 0..<5), label: "some \(i)")
        }
        
        let s = PieChartDataSet(entries: e, label: "Something")
        s.drawIconsEnabled = false
        s.sliceSpace = 2
        
        s.colors = ChartColorTemplates.colorful() + ChartColorTemplates.liberty() + ChartColorTemplates.vordiplom()
        
        return PieChartData(dataSet: s)
    }
    
}
