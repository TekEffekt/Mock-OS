//
//  IoBoundJob.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct IOBoundJob: Job {
    var state: JobState = .waiting
    var processTime = SleepUtilities.ioProcessUnits
    var requestTime = Date()
    var type = JobType.io
    
    var description: String {
        return "State: \(state)  Process Time: \(processTime)  Request Time: \(requestTime) Type: \(type)"
    }
}
