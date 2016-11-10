//
//  OSModel.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class OSModel {
    
    var jobBuffer: JobBuffer
    var producers: [ProducerQueue] = []
    var consumers: [ConsumerQueue] = []
    
    init(withSettings settings: SimulationSettings) {
        let algorithm: Algorithm
        if settings.fifo {
            algorithm = .firstInFirstOut
        } else {
            algorithm = .shortestJobFirst
        }
        jobBuffer = JobBuffer(withAlgorithm: algorithm)
        
        for _ in 1...settings.ioProducerNumber {
            producers.append(ProducerQueue(withBuffer: jobBuffer, andType: .io, andRandom: settings.randomness))
        }
        
        for _ in 1...settings.cpuProducerNumber {
            producers.append(ProducerQueue(withBuffer: jobBuffer, andType: .cpu, andRandom: settings.randomness))
        }
        
        for _ in 1...settings.consumerNumber {
            consumers.append(ConsumerQueue(withBuffer: jobBuffer, andRandom: settings.randomness))
        }
        
        SleepUtilities.cpuProcessUnits = settings.cpuServiceTime
        SleepUtilities.ioProcessUnits = settings.ioServiceTime
        SleepUtilities.cpuSleepUnits = settings.cpuInterarrivalTime
        SleepUtilities.ioSleepUnits = settings.ioInterarrivalTime
    }
    
    func startSimulation() {
        producers.forEach() { producer in producer.start() }
        consumers.forEach() { consumer in consumer.start() }
        Statistics.shared.simulationStartTime = Date()
    }
    
    @objc func stopSimulation() {
        producers.forEach() { producer in producer.cancelAllOperations() }
        consumers.forEach() { consumer in consumer.cancelAllOperations() }
    }
    
}
