//
//  Scheduler.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class JobBuffer {
    
    var jobs : [Job] = []
    let algorithm : Algorithm
    let lock: NSLock
    
    init(withAlgorithm algorithm: Algorithm) {
        self.algorithm = algorithm
        self.lock = NSLock()
    }
    
    func add(job: Job) {
        lock.lock()
        
        jobs.append(job)
        print("Job produced")
        
        lock.unlock()
    }
    
    func removeJob() -> Job? {
        lock.lock()
        
        var job: Job?
        if jobs.count > 0 {
            
            switch algorithm {
                
            case .firstInFirstOut:
                job = jobs.removeLast()
                
            case .shortestJobFirst:
                let cpuJobs = jobs.filter(){ job in job.type == .io ? true : false }
                job = cpuJobs.first!
            }
        }
        
        lock.unlock()
        
        return job
    }
    
}
