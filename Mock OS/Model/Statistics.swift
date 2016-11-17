//
//  Statistics.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class Statistics {
    
    static var shared = Statistics()
    
    // In Units
    var cpuWaitTimes: [Double] = []
    var cpuServiceTimes: [Double] = []
    var cpuTurnaroundTimes: [Double] = []
    var ioWaitTimes: [Double] = []
    var ioServiceTimes: [Double] = []
    var ioTurnaroundTimes: [Double] = []
    var jobsProcessed: Int = 0
    var simulationStartTime: Date?
    
    var averageCpuWaitTime: Double {
        let sum = cpuWaitTimes.reduce(0.0,+)
        let result = sum / Double(cpuWaitTimes.count)
        return secondsToUnits(seconds: result)
    }
    
    var averageCpuServiceTime: Double {
        let sum = cpuServiceTimes.reduce(0.0,+)
        let result = sum / Double(cpuServiceTimes.count)
        return secondsToUnits(seconds: result)
    }
    
    var averageCpuTurnaroundTime: Double {
        let sum = cpuTurnaroundTimes.reduce(0.0,+)
        let result = sum / Double(cpuTurnaroundTimes.count)
        return secondsToUnits(seconds: result)
    }
    
    var averageIoWaitTime: Double {
        let sum = ioWaitTimes.reduce(0.0,+)
        let result = sum / Double(ioWaitTimes.count)
        return secondsToUnits(seconds: result)
    }
    
    var averageIoServiceTime: Double {
        let sum = ioServiceTimes.reduce(0.0,+)
        let result = sum / Double(ioServiceTimes.count)
        return secondsToUnits(seconds: result)
    }
    
    var averageIoTurnaroundTime: Double {
        let sum = ioTurnaroundTimes.reduce(0.0,+)
        let result = sum / Double(ioTurnaroundTimes.count)
        return secondsToUnits(seconds: result)
    }
    
    var processorUtilization: Double {
        guard let startTime = simulationStartTime else { return 0 }
        let totalProcessingTime = cpuServiceTimes.reduce(0.0,+) + ioServiceTimes.reduce(0.0,+)
        let totalSimulationTime = Date().timeIntervalSince(startTime)
        print(startTime)
        print(totalProcessingTime)
        print(totalSimulationTime)
        let result = totalProcessingTime / totalSimulationTime
        let answer = (Double(round(1000*result)/1000) * 100)
        return answer
    }
    
    var processorThroughput: Double {
        guard let startTime = simulationStartTime else { return 0 }
        let totalTime = Date().timeIntervalSince(startTime)
        let result =  Double(jobsProcessed) / totalTime
        return Double(round(1000*result)/1000)
    }
    
    func secondsToUnits(seconds: Double) -> Double {
        return seconds / 0.1
    }
    
}
