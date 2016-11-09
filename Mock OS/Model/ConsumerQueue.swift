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
    
    init(withBuffer buffer: JobBuffer) {
        self.buffer = buffer
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
        let waitTime = Date().timeIntervalSince(job.requestTime)
        let startOfProcessTime = Date()
        SleepUtilities.sleep(forTime: job.processTime)
        let serviceTime = Date().timeIntervalSince(startOfProcessTime)
        
        print("Job Processed - ")
        print(job.description + " Wait Time: \(waitTime)")
        
        updateStatistics(withJob: job, andWaitTime: waitTime, andServiceTime: serviceTime)
    }
    
    private func updateStatistics(withJob job: Job, andWaitTime waitTime: Double, andServiceTime serviceTime: Double) {
        switch job.type {
        case .cpu:
            Statistics.shared.cpuWaitTimes.append(waitTime)
            Statistics.shared.cpuServiceTimes.append(serviceTime)
        case .io:
            Statistics.shared.ioWaitTimes.append(waitTime)
            Statistics.shared.ioServiceTimes.append(serviceTime)
        }
        Statistics.shared.jobsProcessed += 1
    }
    
    override func cancelAllOperations() {
        running = false
    }
    
}
