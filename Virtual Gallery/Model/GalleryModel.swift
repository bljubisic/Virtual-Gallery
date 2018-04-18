//
//  GalleryModel.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 3/26/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

class GalleryModel: GalleryModelProtocol {
    
    private var currentConfiguration: Configuration
    private var currentCriterium: Criterium
    private var pxModel: GalleryPlatformModel
    private var disposeBag: DisposeBag
    
    required init(WithConfiguration configuration: Configuration) {
        currentConfiguration = configuration
        currentCriterium = Criterium()
        pxModel = PxPlatform(WithPlatform: currentConfiguration.getPlatform(WithName: "500px")!)
        disposeBag = DisposeBag()
    }
    
    func setCriterium(_ criterium: Criterium) -> Bool {
        currentCriterium = criterium
        return true
    }
    
    func getCentralImages(WithLimit limit: Int) -> Observable<[Image]> {
        // go through configuration and get all defined platforms.
        // Subscribe to each Variable from them
        // If more than 1 connect all of them using combineWithLatest
        // Resulted observable return as Variable
        return pxModel.getImages(ForCriterium: currentCriterium).asObservable()
        
    }
    
    func getFuzzyImages(WithLimit limit: Int) -> Observable<[Image]> {
        // go through configuration and get all defined platforms.
        // Subscribe to each Variable from them
        // If more than 1 connect all of them using combineWithLatest
        // Resulted observable return as Variable
        return pxModel.getImages(ForCriterium: currentCriterium).asObservable()
    }
    
    
}
