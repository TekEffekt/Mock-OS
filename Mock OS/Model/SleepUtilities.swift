//
//  SleepUtilities.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class SleepUtilities {
    
    static var cpuSleepUnits = 100
    static var ioSleepUnits = 10
    
    static var ioProcessUnits = 5
    static var cpuProcessUnits = 50
    
    static func sleep(forTime timeUnits: Double) {
        Thread.sleep(forTimeInterval: Double(timeUnits) * 0.1)
    }
    
}
