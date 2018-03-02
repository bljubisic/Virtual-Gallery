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
    
    init(WithPlatform platform: Platform)
    
    func connect(WithLogin login: Login) -> Bool
    
    func getImages(ForCriterium criterium: Criterium) -> Variable<[Image]>
    
    func getPlatform() -> Platform
    
    func isLoggedIn(WithLogin login: Login) -> Bool
    
}
