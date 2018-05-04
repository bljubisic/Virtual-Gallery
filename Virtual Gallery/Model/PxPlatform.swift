//
//  PxPlatform.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 3/19/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import RxSwift
import Alamofire
import Foundation
import SwiftyJSON

class PxPlatform: GalleryPlatformModel {
    
    private var platformConfig: PlatformConfig?
    
    var imagesSignal: Variable<Image> = Variable<Image>(Image())
    
    private let bag = DisposeBag()
    
    required init(WithPlatform platform: PlatformConfig) {
        platformConfig = platform
    }
    
    func getPlatform() -> PlatformConfig? {
        return platformConfig
    }
    
    
    func connect(WithLogin login: Login) -> Bool {
        return true
    }
    
    func getImages(ForCriterium criterium: Criterium) -> Observable<Image> {
        guard let platformConfig = self.platformConfig, let endpoint = platformConfig.getEndpoint(WithName: .photos),
            var urlComponent = URLComponents(string: platformConfig.url + endpoint.name.rawValue) else {
            return Observable<Image>.empty()
        }
        
        urlComponent.queryItems = endpoint.parameters.map({ (key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        })
        urlComponent.queryItems?.insert(URLQueryItem(name: "consumer_key", value:platformConfig.consumerKey), at: 0);
        
        Alamofire.request((urlComponent.url)!).responseJSON { (response) in
            guard let jsonResponse = response.result.value else {
                return
            }
            
            let photosJSON = JSON(jsonResponse)
            let photos = photosJSON["photos"].arrayValue
            _ = photos.map({ (photo) -> Image in
                let name = photo["name"].stringValue
                let largeURL = photo["image_url"].arrayValue[1].stringValue
                let thumbURL = photo["image_url"].arrayValue[0].stringValue
                let description = photo["description"].stringValue
                let url = "https://500px.com/photos/" + photo["id"].stringValue
                    
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                let date =  dateFormatter.date(from:photo["created_at"].stringValue)
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date!)
                    
                let user = photo["user"]
                let username = user["username"].stringValue
                let firstname = user["firstname"].stringValue
                let lastname = user["lastname"].stringValue
                let avatar = user["userpis_url"].stringValue
                let userURL = "https://500px.com/\(username)/"
                    
                let author = Author(username: username, firstName: firstname, lastName: lastname, avatar: avatar, url: userURL)
                    
                let platform = Platform(name: .px, homeURL: "https://500px.com/", haveAccount: false)
                    
                let comments = photo["comments"].arrayValue.map{ (json) -> String in
                    return json.stringValue
                }
                let tags = photo["tags"].arrayValue.map({ (json) -> String in
                    return json.stringValue
                })
                    
                let image = Image(name: name, largeURL: largeURL, thumbURL: thumbURL, description: description, url: url, year: year, exif: Exif(), author: author, comments: comments, tags: tags, platform: platform)
                self.imagesSignal.value = image
                return image
            })

        }
        return self.imagesSignal.asObservable()
    }
    
    func getFuzzyImages(ForTags tags: [String]) -> Observable<Image> {
        var foundImages = [Image]()
        
        guard let platformConfig = self.platformConfig, let endpoint = platformConfig.getEndpoint(WithName: .search),
            var urlComponent = URLComponents(string: platformConfig.url + endpoint.name.rawValue) else {
                return Observable<Image>.empty()
        }
        
        urlComponent.queryItems = endpoint.parameters.map({ (key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        })
        urlComponent.queryItems?.insert(URLQueryItem(name: "term", value: tags.compactMap({ $0 }).joined(separator: " ")), at: 0)
        urlComponent.queryItems?.insert(URLQueryItem(name: "consumer_key", value:platformConfig.consumerKey), at: 0)
    
        
        Alamofire.request((urlComponent.url)!).responseJSON { (response) in
            guard let jsonResponse = response.result.value else {
                return
            }
            
            let photosJSON = JSON(jsonResponse)
            let photos = photosJSON["photos"].arrayValue
    
            _ = photos.map({ (photo) -> Image in
                let name = photo["name"].stringValue
                let largeURL = photo["image_url"].arrayValue[1].stringValue
                let thumbURL = photo["image_url"].arrayValue[0].stringValue
                let description = photo["description"].stringValue
                let url = "https://500px.com/photos/" + photo["id"].stringValue
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                let date =  dateFormatter.date(from:photo["created_at"].stringValue)
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date!)
                
                let user = photo["user"]
                let username = user["username"].stringValue
                let firstname = user["firstname"].stringValue
                let lastname = user["lastname"].stringValue
                let avatar = user["userpis_url"].stringValue
                let userURL = "https://500px.com/\(username)/"
                
                let author = Author(username: username, firstName: firstname, lastName: lastname, avatar: avatar, url: userURL)
                
                let platform = Platform(name: .px, homeURL: "https://500px.com/", haveAccount: false)
                
                let comments = photo["comments"].arrayValue.map{ (json) -> String in
                    return json.stringValue
                }
                let tags = photo["tags"].arrayValue.map({ (json) -> String in
                    return json.stringValue
                })
                
                let image = Image(name: name, largeURL: largeURL, thumbURL: thumbURL, description: description, url: url, year: year, exif: Exif(), author: author, comments: comments, tags: tags, platform: platform)
                foundImages.append(image)
                return image
            })
            
        }
        if(foundImages.count == 0) {
            var newTags = tags
            if(newTags.count > 0) {
                _ = newTags.removeLast()
                return self.getFuzzyImages(ForTags: newTags)
            }
            else {
                return self.getImages(ForCriterium: Criterium())
            }

        }
    
        return Observable.from(foundImages)
    }
    
    func isLoggedIn(WithLogin login: Login) -> Bool {
        return false
    }
    
    func downloadImageFor(URL url: String) -> Observable<Data> {
        let dataObservable = Variable<Data>(Data())
        Alamofire.request(url).responseData { (response) in
            
            guard let data = response.data else {
                return
            }
            dataObservable.value = data
        }
        return dataObservable.asObservable()
    }
    
    
}
