//
//  EnvironmentProtocol.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 3/9/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation

protocol EnvironmentModel {
    
    var currentConfiguration: Configuration { get set }
    var galleryModel: GalleryModelProtocol { get set }
    
    static func create(Configuration config: Configuration) -> EnvironmentModel
    
}
