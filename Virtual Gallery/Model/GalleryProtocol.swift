//
//  GalleryProtocol.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 1/23/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

protocol GalleryModelProtocol: class {
    
    init(WithConfiguration configuration: Configuration)
    
    func setCriterium(_ criterium: Criterium) -> Bool
    
    func getCentralImages(WithLimit limit: Int) -> Variable<[Image]>
    
    func getFuzzyImages(WithLimit limit: Int) -> Variable<[Image]>
    
    
}
