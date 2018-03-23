//
//  GalleryData.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 1/26/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation

struct Criterium {
    let searchText: String
    let  safeSearch: Bool
}

extension Criterium {
    init() {
        searchText = ""
        safeSearch = false
    }
}

struct Image {
    let name: String
    let largeURL: String
    let thumbURL: String
    let description: String
    let url: String
    let year: Int
    let exif: Exif
    let author: Author
    let comments: [String]
    let platform: Platform
}

extension Image {
    init() {
        name        = ""
        url         = ""
        platform    = Platform()
        largeURL    = ""
        thumbURL    = ""
        description = ""
        year        = 0
        exif        = Exif()
        author      = Author()
        comments    = [""]
    }
}

struct Exif {
    let exposure: String
    let camera: String
    let aperture: String
    let licence: String
    let iso: String
    let focalLength: String
}

extension Exif {
    init() {
        exposure    = ""
        camera      = ""
        aperture    = ""
        licence     = ""
        iso         = ""
        focalLength = ""
    }
}

struct Author {
    let username: String
    let firstName: String
    let lastName: String
    let avatar: String
    let url: String
}

extension Author {
    init() {
        username  = ""
        firstName = ""
        lastName  = ""
        avatar    = ""
        url       = ""
    }
}

struct Platform {
    let name: String
    let homeURL: String
    let haveAccount: Bool
}

extension Platform {
    init() {
        name        = ""
        homeURL     = ""
        haveAccount = false
    }
}

struct Login {
    let username: String
    let password: String
    let token: String
}

extension Login {
    init() {
        username = ""
        password = ""
        token    = ""
    }
}

struct Credentials {
    let name: String
    let username: String
    let password: String
    let url: String
    let token: String
}
extension Credentials {
    init() {
        name = ""
        username = ""
        password = ""
        url = ""
        token = ""
    }
}

struct Endpoint {
    let name: String
    let parameters: [String:String]
}

struct PlatformConfig {
    let name: String
    let url: String
    let enabled: Bool
    let login: Bool
    let consumerKey: String
    let consumerSecret: String
    let credentials: Credentials
    let endpoints: [Endpoint]
    
    func getEndpoint(WithName name: String) -> Endpoint? {
        return endpoints.filter({ (endpoint) -> Bool in
            return endpoint.name == name
        }).first
    }
}

struct Configuration {
    let platforms: [PlatformConfig]
    
}

extension Configuration {
    init() {
        let px500 = PlatformConfig(name: "500px", url: "https://api.500px.com/v1/", enabled: true, login: false, consumerKey: "bJIWpSFuD1lhcEzdl1Iss452mNEq4LbMEIWxV9F4", consumerSecret: "0gux5pA3HanYTr8K78KQ9pPydNvJ12Sy0rSbpypL", credentials: Credentials(), endpoints:[ Endpoint(name: "photos", parameters: ["feature":"popular", "sort":"created_at", "image_size":"2,4", "rpp":"10"])])
        platforms = [px500]
    }
}

