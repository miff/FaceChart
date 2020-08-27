//
//  BarGraphService.swift
//  FaceChart
//
//  Created by Milan Djordjevic on 8/27/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import Charts
import Foundation


class BarGraphService {
    
    init() {}
    static let shared = BarGraphService()
    
    func getData(of bounds: Int = 3) -> BarChartData {
        let e = (0..<bounds).map { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double.random(in: 0..<5), y: Double.random(in: 0..<5))
        }
        
        let s = BarChartDataSet(entries: e, label: "Some Bars")
        s.colors = ChartColorTemplates.colorful() + ChartColorTemplates.liberty() + ChartColorTemplates.vordiplom()
        
        return BarChartData(dataSet: s)
    }
    
}
