//
//  BarChartView.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/5/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit
import Charts

class BarChart: UIView {
    
    // Bar chart properties
    let barChartView = BarChartView()
    var dataEntry: [BarChartDataEntry] = []
    
    // Chart data
    var workoutDuration = [String]()
    var calories = [String]()
    var dates = [String]()
    var miles = [String]()
    var legend = String()
    
    var delegate: GetChartData! {
        didSet {
            populateData()
            barChartSetup()
        }
    }
    
    func populateData() {
        workoutDuration = delegate.workoutDuration
        miles = delegate.miles
        dates = delegate.dates
        calories = delegate.calories
        legend = delegate.legend
    }
    
    func barChartSetup() {
        // Bar chart config
        self.backgroundColor = UIColor.themeMediumBlue
        self.addSubview(barChartView)
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        barChartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        barChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        barChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        barChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        // Bar chart animation
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        setBarChart(dataPoints: dates, values: workoutDuration, legend: legend)
    }
    
    func setBarChart(dataPoints: [String], values: [String], legend: String) {
        dataEntry.removeAll()
        
        // No data setup
        barChartView.noDataTextColor = UIColor.white
        barChartView.noDataText = "No data for the chart."
        barChartView.backgroundColor = UIColor.white
        
        // Data point setup & color config
        for i in 0..<dataPoints.count {
            let dataPoint = BarChartDataEntry(x: Double(i), y: Double(values[i])!)
            dataEntry.append(dataPoint)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntry, label: legend)
        let chartData = BarChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(false) // true if want values above bar
        chartDataSet.colors = [UIColor.themeLightGreen]
        
        // Axes setup
        let formatter: ChartFormatter = ChartFormatter()
        formatter.setValues(values: dataPoints)
        let xaxis:XAxis = XAxis()
        xaxis.valueFormatter = formatter
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawGridLinesEnabled = false // true if want X-Axis grid lines
        barChartView.xAxis.valueFormatter = xaxis.valueFormatter
        barChartView.chartDescription?.enabled = false
        barChartView.legend.enabled = true
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false // true if want Y-Axis grid lines
        barChartView.leftAxis.drawLabelsEnabled = true
        barChartView.data = chartData
        barChartView.backgroundColor = UIColor.themeMediumBlue
        barChartView.xAxis.labelTextColor = UIColor.white
        barChartView.legend.textColor = UIColor.white
        barChartView.legend.font = UIFont(name: "Optima-Bold", size: 12)!
        barChartView.barData?.setValueTextColor(UIColor.white)
        barChartView.leftAxis.labelTextColor = UIColor.white
        barChartView.xAxis.granularity = 1
    }
}
