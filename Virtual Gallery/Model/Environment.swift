//
//  Environment.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 3/9/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation

class Environment: EnvironmentModel {
    var currentConfiguration: Configuration = Configuration()
    
    func create(Configuration config: Configuration) -> Bool {
        currentConfiguration = config
        return true
    }
    
    
}
