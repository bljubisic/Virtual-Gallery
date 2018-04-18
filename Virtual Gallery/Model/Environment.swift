//
//  Environment.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 3/9/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation

class Environment: EnvironmentModel {
    
    var currentConfiguration: Configuration
    var galleryModel: GalleryModelProtocol
    
    static func create(Configuration config: Configuration) -> EnvironmentModel {
        let environment = Environment()
        
        environment.currentConfiguration = config
        environment.galleryModel = GalleryModel(WithConfiguration: environment.currentConfiguration)
        return environment
    }
    
    private init() {
        currentConfiguration = Configuration()
        galleryModel = GalleryModel(WithConfiguration: currentConfiguration)
    }
    
    
}
