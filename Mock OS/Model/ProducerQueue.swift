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
    var random: Bool
    
    init(withBuffer buffer: JobBuffer, andType jobType: JobType, andRandom random: Bool) {
        self.buffer = buffer
        self.jobType = jobType
        self.random = random
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
        
        let offset = random ? RandomGenerator.generate() : 1.0
        
        switch self.jobType {
        case .cpu:
            SleepUtilities.sleep(forTime: Double(SleepUtilities.cpuSleepUnits) * offset)
        case .io:
            SleepUtilities.sleep(forTime: Double(SleepUtilities.ioSleepUnits) * offset)
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

