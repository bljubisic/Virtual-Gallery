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
        name = ""
        homeURL = ""
        haveAccount = false
    }
}

