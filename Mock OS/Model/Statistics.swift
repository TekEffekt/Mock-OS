//
//  Statistics.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class Statistics {
    
    static let shared = Statistics()
    
    var cpuWaitTimes: [Double] = []
    var cpuServiceTimes: [Double] = []
    var ioWaitTimes: [Double] = []
    var ioServiceTimes: [Double] = []
    var jobsProcessed: Int = 0
    var simulationStartTime: Date?
    
    var averageCpuWaitTimes: Double {
        let sum = cpuWaitTimes.reduce(0.0,+)
        return sum / Double(cpuWaitTimes.count)
    }
    
    var averageCpuServiceTime: Double {
        let sum = cpuServiceTimes.reduce(0.0,+)
        return sum / Double(cpuServiceTimes.count)
    }
    
    var averageIoWaitTimes: Double {
        let sum = ioWaitTimes.reduce(0.0,+)
        return sum / Double(ioWaitTimes.count)
    }
    
    var averageIoServiceTime: Double {
        let sum = ioServiceTimes.reduce(0.0,+)
        return sum / Double(ioServiceTimes.count)
    }
    
    var processorUtilization: Double {
        guard let startTime = simulationStartTime else { return 0 }
        let totalProcessingTime = cpuServiceTimes.reduce(0.0,+) + ioServiceTimes.reduce(0.0,+)
        let result = totalProcessingTime / Date().timeIntervalSince(startTime)
        return Double(round(1000*result)/1000) * 100
    }
    
    var processorThroughput: Double {
        guard let startTime = simulationStartTime else { return 0 }
        let totalTime = Date().timeIntervalSince(startTime)
        let result = totalTime / Double(jobsProcessed)
        return Double(round(1000*result)/1000)
    }
}
