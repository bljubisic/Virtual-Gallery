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
    var centralLine: [Image] { set get }
    var fuzzyImages: [Image] { set get }
    var currentCentralImage: Image { set get }
    
    init(withModel model:GalleryModelProtocol)
    
    func getImagesForCentralLine(forCriterium criteria:Criterium, andCompletion completion:@escaping ([Image]) -> Void) -> Void
    
    func downloadDataFor(ImageURL url: String, withCompletion completion: @escaping(Data) -> Void)
}
