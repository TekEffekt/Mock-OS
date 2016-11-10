//
//  ResultsViewController.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var resultString = ""
        resultString += "Average CPU waiting time: \(Statistics.shared.averageCpuWaitTime) \n"
        resultString += "Average IO waiting time: \(Statistics.shared.averageIoWaitTime) \n \n"
        resultString += "Average CPU service time: \(Statistics.shared.averageCpuServiceTime) \n"
        resultString += "Average IO service time: \(Statistics.shared.averageIoServiceTime) \n \n"
        resultString += "Average CPU turnaround time: \(Statistics.shared.averageCpuTurnaroundTime) \n"
        resultString += "Average IO turnaround time: \(Statistics.shared.averageIoTurnaroundTime) \n \n"
        resultString += "Processor Utilization: \(Statistics.shared.processorUtilization)% \n"
        resultString += "Processor Throughout: \(Statistics.shared.processorThroughput) per second \n"
        
        resultView.text = resultString
        
        Statistics.shared = Statistics()
    }

}
