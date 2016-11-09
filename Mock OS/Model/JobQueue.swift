//
//  JobQueue.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

protocol JobQueue {
    var buffer: JobBuffer { get }
    func start()
}
