//
//  SimulationSettings.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct SimulationSettings {
    var fifo = true
    var shorted = false
    var ioProducerNumber = 1
    var cpuProducerNumber = 1
    var consumerNumber = 1
    var cpuInterarrivalTime = 100
    var cpuServiceTime = 50
    var ioInterarrivalTime = 10
    var ioServiceTime = 5
}
