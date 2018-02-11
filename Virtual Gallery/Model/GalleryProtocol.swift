//
//  GalleryProtocol.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 1/23/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

protocol GalleryModel: class {
    
    func getImagesFor(_ criterium: Criterium) -> Variable<Image> 
    
}
