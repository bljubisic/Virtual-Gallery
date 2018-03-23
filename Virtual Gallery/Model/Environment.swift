//
//  Environment.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 3/9/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation

class Environment: EnvironmentModel {
    
    var currentConfiguration: Configuration?
    var currentEnvironment: EnvironmentModel = Environment()
    
    static func create(Configuration config: Configuration) -> EnvironmentModel {
        
        let environment = Environment()
        
        environment.currentConfiguration = config
        environment.currentEnvironment = environment
        return environment
    }
    
    private init() {
        
    }
    
    
}
