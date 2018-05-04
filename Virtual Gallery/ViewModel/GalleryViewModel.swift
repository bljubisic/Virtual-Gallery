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
    var centralLine: [Image] = [Image]()
    var fuzzyImages: [Image] = [Image]()
    var currentCentralImage: Image = Image()
    
    private let disposeBag: DisposeBag
    
    required init(withModel model: GalleryModelProtocol) {
        self.model = model
        disposeBag = DisposeBag()
    }
    
    func getImagesForCentralLine(forCriterium criteria: Criterium, andCompletion completion:@escaping ([Image]) -> Void) -> Void{
        self.centralLine = [Image] ()
        var tmpCentralLine = [Image]()
        
        self.model.getCentralImages(WithLimit: 10).filter { (image) -> Bool in
            return image.name != ""
        }.map({[unowned self] (image) -> Image in
            self.centralLine.append(image)
            return image
        }).take(3).subscribe( onNext: {result in
            tmpCentralLine.append(result)
        }, onError: { (Error) in
            print("!!!!error")
        }, onCompleted: {
            print("!!!!completed")
        }) {
            if(tmpCentralLine.count >= 3) {
                self.currentCentralImage = tmpCentralLine[1]
                completion(tmpCentralLine)
            }
        }.disposed(by: disposeBag)
    }
    
    func getFuzzyImages(forTags tags: [String], andCompletion completion: @escaping ([Image]) -> Void) {
        self.fuzzyImages = [Image] ()
        var tmpFuzzyImages = [Image]()
        
        self.model.getFuzzyImages(WithTags: tags, AndWithLimit: 10).filter { (image) -> Bool in
            return image.name != ""
            }.map { (image) -> Image in
                self.fuzzyImages.append(image)
                print(image.name)
                return image
            }.take(6).subscribe(onNext: { (result) in
                tmpFuzzyImages.append(result)
            }, onError: { (Error) in
            
            }, onCompleted: {

            }) {
                print("!!!Completed fuzzy!!!")
                if(tmpFuzzyImages.count >= 6) {
                    completion(tmpFuzzyImages)
                }
        }.disposed(by: disposeBag)
    }
    
    func downloadDataFor(ImageURL url: String, withCompletion completion: @escaping (Data) -> Void) {
        self.model.downloadImageFrom(URL: url).filter { (data) -> Bool in
            return !data.isEmpty
        }.subscribe(onNext: { (data) in
            completion(data)
        }, onError: { (Error) in
            
        }, onCompleted: {
            
        }) {
            
            }.disposed(by: disposeBag)
    }
    
    
}
