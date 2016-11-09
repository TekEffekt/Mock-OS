//
//  Job.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

protocol Job {
    var state: JobState { get }
    var processTime: Int { get}
    var requestTime: Date { get }
    var type: JobType { get }
    var description: String { get }    
}
