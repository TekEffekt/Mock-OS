//
//  ConsumerQueue.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class ConsumerQueue: OperationQueue, JobQueue {
    
    var buffer: JobBuffer
    var running = false
    var random: Bool
    var consumerNumber: Double = 1
    
    init(withBuffer buffer: JobBuffer, andRandom random: Bool, andConsumerNumber consumers: Int) {
        self.buffer = buffer
        self.random = random
        self.consumerNumber = Double(consumers)
    }
    
    func start() {
        running = true
        
        addOperation {
            while(self.running) {
                let job = self.buffer.removeJob()
                if let job = job {
                    self.consume(job: job)
                }
            }
        }
    }
    
    func consume(job: Job) {
        let offset = random ? RandomGenerator.generate() : 1.0
        let waitTime = (Date().timeIntervalSince(job.requestTime))
        let beforeServiceDate = Date()
        SleepUtilities.sleep(forTime: Double(job.processTime) * offset)
        let serviceTime = Date().timeIntervalSince(beforeServiceDate)
        print(" Service Time \(serviceTime)")
        
        print("Job Processed - ")
        print(job.description + " Wait Time: \(waitTime)")
        
        updateStatistics(withJob: job, andWaitTime: waitTime, andServiceTime: Double(serviceTime))
    }
    
    private func updateStatistics(withJob job: Job, andWaitTime waitTime: Double, andServiceTime serviceTime: Double) {
        switch job.type {
        case .cpu:
            Statistics.shared.cpuWaitTimes.append(waitTime)
            Statistics.shared.cpuServiceTimes.append(serviceTime)
            Statistics.shared.cpuTurnaroundTimes.append(waitTime + serviceTime)
        case .io:
            Statistics.shared.ioWaitTimes.append(waitTime)
            Statistics.shared.ioServiceTimes.append(serviceTime)
            Statistics.shared.ioTurnaroundTimes.append(waitTime + serviceTime)
        }
        Statistics.shared.jobsProcessed += 1
    }
    
    override func cancelAllOperations() {
        running = false
    }
    
}
