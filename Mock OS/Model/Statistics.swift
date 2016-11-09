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
        return sum / Double(cpuWaitTimes.count)
    }
    
    var averageCpuServiceTime: Double {
        let sum = cpuServiceTimes.reduce(0.0,+)
        return sum / Double(cpuServiceTimes.count)
    }
    
    var averageCpuTurnaroundTime: Double {
        let sum = cpuTurnaroundTimes.reduce(0.0,+)
        return sum / Double(cpuTurnaroundTimes.count)
    }
    
    var averageIoWaitTime: Double {
        let sum = ioWaitTimes.reduce(0.0,+)
        return sum / Double(ioWaitTimes.count)
    }
    
    var averageIoServiceTime: Double {
        let sum = ioServiceTimes.reduce(0.0,+)
        return sum / Double(ioServiceTimes.count)
    }
    
    var averageIoTurnaroundTime: Double {
        let sum = ioTurnaroundTimes.reduce(0.0,+)
        return sum / Double(ioTurnaroundTimes.count)
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
