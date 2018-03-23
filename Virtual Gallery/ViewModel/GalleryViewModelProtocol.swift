//
//  GalleryViewModelProtocol.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 2/11/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

protocol GalleryViewModelProtocol: class {
    
    var model: GalleryModelProtocol { get }
    
    init(withModel model:GalleryModelProtocol)
    
    func getImagesForCentralLine(forCriterium criteria:Criterium) -> Observable<[Image]>
    
    
}
