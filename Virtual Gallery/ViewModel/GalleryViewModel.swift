//
//  GalleryViewModel.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 3/23/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

class GalleryViewModel: GalleryViewModelProtocol {
    
    let model: GalleryModelProtocol
    
    required init(withModel model: GalleryModelProtocol) {
        self.model = model
    }
    
    func getImagesForCentralLine(forCriterium criteria: Criterium) -> Observable<[Image]> {
        let centralLine = model.getCentralImages(WithLimit: 10).asObservable()
        return centralLine
        
    }
    
    
}
