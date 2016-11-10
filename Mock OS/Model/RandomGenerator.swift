//
//  RandomGenerator.swift
//  Mock OS
//
//  Created by Kyle Zawacki on 11/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class RandomGenerator {
    
    static func generate() -> Double {
        var offset = 1.0
        let randomFloat = Float(arc4random()) / Float(UINT32_MAX)
        offset = -log(Double(randomFloat))
        return offset
    }
    
}
