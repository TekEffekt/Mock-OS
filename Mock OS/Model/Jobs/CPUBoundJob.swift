//
//  CpuBoundJob.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct CPUBoundJob: Job {
    var state: JobState = .waiting
    var processTime = SleepUtilities.cpuProcessUnits
    var requestTime = Date()
    var type = JobType.cpu
    
    var description: String {
        return "State: \(state)  Process Time: \(processTime)  Request Time: \(requestTime) Type: \(type)"
    }
    
}
