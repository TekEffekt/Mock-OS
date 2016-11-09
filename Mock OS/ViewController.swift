//
//  ViewController.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import MBProgressHUD

class SimulationSettingsController: UITableViewController {
    
    var model: OSModel?
    var settings = SimulationSettings()
    var activityHud: MBProgressHUD?
    @IBOutlet weak var fifoSwitch: UISwitch!
    @IBOutlet weak var shortestSwitch: UISwitch!
    var timer: Timer?
    
    @IBAction func startSimulation(_ sender: AnyObject) {
//        if let timeLimit = settings.timeLimit {
//            let seconds = Double(Int(Double(timeLimit) * 0.1))
//            print(seconds)
//            perform(#selector(self.stopSimulation(_:)), with: nil, afterDelay: seconds)
//        }
        
        model = OSModel(withSettings: settings)
        model?.startSimulation()
        activityHud = MBProgressHUD.showAdded(to: navigationController!.view, animated: true)
        activityHud?.label.text = "Simulating..."
        activityHud?.isUserInteractionEnabled = false
    }
    
    @IBAction func stopSimulation(_ sender: AnyObject) {
        model?.stopSimulation()
        print("Average CPU waiting time: \(Statistics.shared.averageCpuWaitTime)")
        print("Average IO waiting time: \(Statistics.shared.averageIoWaitTime)")
        
        print("Average CPU service time: \(Statistics.shared.averageCpuServiceTime)")
        print("Average IO service time: \(Statistics.shared.averageIoServiceTime)")
        
        print("Average CPU turnaround time: \(Statistics.shared.averageCpuTurnaroundTime)")
        print("Average IO turnaround time: \(Statistics.shared.averageIoTurnaroundTime)")
        
        print("Processor Utilization: \(Statistics.shared.processorUtilization)%")
        print("Processor Throughout: \(Statistics.shared.processorThroughput) per second")
        
        activityHud?.hide(animated: true)
        Statistics.shared = Statistics()
    }

    @IBAction func fifoSwitchChanged(_ sender: UISwitch) {
        settings.fifo = sender.isOn
        shortestSwitch.setOn(!sender.isOn, animated: true)
    }
    
    @IBAction func shortestSwitchChanged(_ sender: UISwitch) {
        settings.shorted = sender.isOn
        fifoSwitch.setOn(!sender.isOn, animated: true)
    }
    
    @IBAction func ioProducerNumberChanged(_ sender: UISlider) {
        settings.ioProducerNumber = Int(sender.value)
        updateLabel(withValue: Int(sender.value), andSender: sender)
    }
    
    @IBAction func cpuProducerNumber(_ sender: UISlider) {
        settings.cpuProducerNumber = Int(sender.value)
        updateLabel(withValue: Int(sender.value), andSender: sender)
    }
    
    @IBAction func consumerNumberChanged(_ sender: UISlider) {
        settings.consumerNumber = Int(sender.value)
        updateLabel(withValue: Int(sender.value), andSender: sender)
    }
    
    @IBAction func ioServiceTimeChanged(_ sender: UISlider) {
        settings.ioServiceTime = Int(sender.value)
        updateLabel(withValue: Int(sender.value), andSender: sender)
    }
    
    @IBAction func cpuServiceTimeChanged(_ sender: UISlider) {
        settings.cpuServiceTime = Int(sender.value)
        updateLabel(withValue: Int(sender.value), andSender: sender)
    }
    
    @IBAction func ioInterrarivalTimeChanged(_ sender: UISlider) {
        settings.ioInterarrivalTime = Int(sender.value)
        updateLabel(withValue: Int(sender.value), andSender: sender)
    }
    
    @IBAction func cpuInterrarivalTimeChanged(_ sender: UISlider) {
        settings.cpuInterarrivalTime = Int(sender.value)
        updateLabel(withValue: Int(sender.value), andSender: sender)
    }
    
    func updateLabel(withValue value: Int, andSender sender: UIControl) {
        let superView = sender.superview
        if let label = superView?.subviews.last as? UILabel {
            label.text = "\(value)"
        }
    }
    
    @IBAction func timeLimitChanged(_ sender: UISlider) {
        settings.timeLimit = Int(sender.value)
        
        if sender.value == 0 {
            settings.timeLimit = nil
        }
    }
    
}

