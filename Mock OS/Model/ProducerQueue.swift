//
//  ProducerQueue.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class ProducerQueue: OperationQueue, JobQueue {
    
    var buffer: JobBuffer
    var running = false
    var jobType: JobType
    
    init(withBuffer buffer: JobBuffer, andType jobType: JobType) {
        self.buffer = buffer
        self.jobType = jobType
    }
    
    func start() {
        running = true
        
        addOperation { 
            while(self.running) {
                self.simulateProductionTime()
            }
        }
    }
    
    func simulateProductionTime() {
        produce()
        
        switch self.jobType {
        case .cpu:
            SleepUtilities.sleep(forTime: SleepUtilities.cpuSleepUnits)
        case .io:
            SleepUtilities.sleep(forTime: SleepUtilities.cpuSleepUnits)
        }
    }
    
    func produce() {
        let job: Job
        switch jobType {
        case .cpu:
            job = CPUBoundJob()
        case .io:
            job = IOBoundJob()
        }
        buffer.add(job: job)
    }
    
    override func cancelAllOperations() {
        running = false
    }
    
}

