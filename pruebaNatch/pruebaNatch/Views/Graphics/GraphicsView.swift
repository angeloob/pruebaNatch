//
//  GraphicsView.swift
//  pruebaNatch
//
//  Created by Angel Olvera on 21/06/21.
//

import UIKit
import Charts

class GraphicsView: UIViewController {
    
    var pieChart = PieChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
//        NetworkingProvider.shared.getUser { data in
//            <#code#>
//        } failure: { error in
//            debugPrint("error al descargar los datos, \(error?.localizedDescription ?? "no hay error")")
//        }
    }
    
    override func viewDidLayoutSubviews() {
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        var entries = [ChartDataEntry]()
        for x in 0..<10{
            entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.colorful()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }
}

extension GraphicsView: ChartViewDelegate{
    
}
