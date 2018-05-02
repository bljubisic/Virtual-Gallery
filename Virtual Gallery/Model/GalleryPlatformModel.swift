//
//  GalleryPlatformModel.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 3/3/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

protocol GalleryPlatformModel: class {
    
    var imagesSignal: Variable<Image> { get }
    
    init(WithPlatform platform: PlatformConfig)
    
    func connect(WithLogin login: Login) -> Bool
    
    func getImages(ForCriterium criterium: Criterium) -> Observable<Image>
    
    func downloadImageFor(URL url: String) -> Observable<Data>
    
    func getPlatform() -> PlatformConfig?
    
    func isLoggedIn(WithLogin login: Login) -> Bool
    
}
