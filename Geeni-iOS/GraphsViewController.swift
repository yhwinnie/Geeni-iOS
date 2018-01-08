//
//  GraphsViewController.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 04/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import UIKit
import TKRadarChart
import PieCharts

class GraphsViewController : UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let radarChartTitleArray : [String] = ["Adaptable" , "Concise" , "Patient" , "Encouraging " ,"Organised " , "Social/Humour" , "Good Pace" ,  "Helpful"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupProfileView()
        setupRadarGraph()
        setupPieChart()
    }
    
    func setupScrollView(){
        scrollView.contentSize.width = self.view.frame.width
        scrollView.backgroundColor = colors.whiteColor
        scrollView.contentSize.height = 0.0
    }
    
    func setupProfileView(){
        let profileImageView = Bundle.main.loadNibNamed("ProfileImageXib", owner: self, options: nil)![0] as? ProfileImageXib
        profileImageView?.frame = CGRect(x: 0.0, y: -statusBarHeight, width: self.view.frame.width, height: 250)
        profileImageView?.center.x = self.view.center.x
        scrollView.addSubview(profileImageView!)
        scrollView.contentSize.height += 250
    }
    
    func setupRadarGraph(){
        let width = self.view.frame.width - 10.0
        let radarChart = TKRadarChart(frame : CGRect(x: 5, y: 250, width: width, height: width))
        radarChart.configuration.radius = width/3
        radarChart.tintColor = colors.blueColor
        radarChart.center.x = self.view.center.x
        radarChart.delegate = self
        radarChart.dataSource = self
        scrollView.addSubview(radarChart)
        scrollView.contentSize.height += width + 20
    }
    
    func setupPieChart() {
        let pieChart = PieChart(frame: CGRect(x: self.view.center.x - 125.0, y: self.view.frame.width + 260.0, width: 250.0, height: 250.0))
        pieChart.layers = [createCustomViewsLayer()]
        pieChart.innerRadius = 0.0
        pieChart.models  =  [PieSliceModel(value: 3, color: UIColor.blue),
                             PieSliceModel(value: 1, color : UIColor.orange),
                             PieSliceModel(value: 2.5, color: UIColor.yellow),
                             PieSliceModel(value: 1, color: UIColor.red),
                             PieSliceModel(value: 2, color: colors.blueColor)]
        pieChart.strokeColor = colors.whiteColor
        pieChart.strokeWidth = 2.0
        scrollView.addSubview(pieChart)
        scrollView.contentSize.height += 250
    }
    
    func createCustomViewsLayer() -> PieCustomViewsLayer {
        let viewLayer = PieCustomViewsLayer()
        let settings = PieCustomViewsLayerSettings()
        settings.viewRadius = 125
        settings.hideOnOverflow = false
        viewLayer.settings = settings
        return viewLayer
    }
    
    func setupBarChart() {
        //todo
    }
}

extension GraphsViewController : TKRadarChartDataSource , TKRadarChartDelegate {
    
    func numberOfRowForRadarChart(_ radarChart: TKRadarChart) -> Int {
        return 8
    }
    
    func numberOfStepForRadarChart(_ radarChart: TKRadarChart) -> Int {
        return 8
    }
    
    func numberOfSectionForRadarChart(_ radarChart: TKRadarChart) -> Int {
        return 1
    }
    
    func valueOfSectionForRadarChart(withRow row: Int, section: Int) -> CGFloat {
        return CGFloat(max(min(row + 1, 4), 3))
    }
    
    func titleOfRowForRadarChart(_ radarChart: TKRadarChart, row: Int) -> String {
        return radarChartTitleArray[row]
    }
    
    func colorOfLineForRadarChart(_ radarChart: TKRadarChart) -> UIColor {
        return UIColor.gray
    }
    
    func colorOfFillStepForRadarChart(_ radarChart: TKRadarChart, step: Int) -> UIColor {
        return UIColor.lightGray
    }
    
    func colorOfSectionFillForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor {
        return colors.blueColor.withAlphaComponent(0.5)
    }
    
    func colorOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIColor {
        return colors.whiteColor
    }
}


