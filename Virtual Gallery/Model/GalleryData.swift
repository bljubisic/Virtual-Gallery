//
//  GalleryData.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 1/26/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import Foundation

enum Platforms: String {
    case empty = ""
    case px = "500px"
    case flickr = "Flickr"
    case instagram = "Instagram"
}

enum Endpoints: String {
    case photos = "photos"
}

struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}

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
    let name: Platforms
    let homeURL: String
    let haveAccount: Bool
}

extension Platform {
    init() {
        name        = .empty
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
    let name: Endpoints
    let parameters: [String:String]
}

struct PlatformConfig {
    let name: Platforms
    let url: String
    let enabled: Bool
    let login: Bool
    let consumerKey: String
    let consumerSecret: String
    let credentials: Credentials
    let endpoints: [Endpoint]
    let model: GalleryPlatformModel?
    
    func getEndpoint(WithName name: String) -> Endpoint? {
        return endpoints.filter({ (endpoint) -> Bool in
            return endpoint.name.rawValue == name
        }).first
    }
    func add(Model model: GalleryModelProtocol) -> Bool {
        return true
    }
}

extension PlatformConfig {
    static let platformConfigLens = Lens<PlatformConfig, GalleryPlatformModel> (
        get: { $0.model! },
        set: { (gmp, pc) in PlatformConfig(name: pc.name, url: pc.url, enabled: pc.enabled, login: pc.login,
                                           consumerKey: pc.consumerKey, consumerSecret: pc.consumerSecret,
                                           credentials: pc.credentials, endpoints: pc.endpoints, model: gmp) }
    )
}

struct Configuration {
    let platforms: [PlatformConfig]
    
    
    func getPlatform(WithName name: String) -> PlatformConfig? {
        return platforms.filter({ (platformConfig) -> Bool in
            return platformConfig.name.rawValue == name
        }).first
    }
    
    func updatePlatform(WithName name: String, WithPlatform platform: PlatformConfig) -> Configuration {
        var newPlatforms = platforms.filter { (platformConfig) -> Bool in
            return platformConfig.name.rawValue != name
        }
        newPlatforms.insert(platform, at: 0)
        return Configuration(platforms: newPlatforms)
    }
    
}

extension Configuration {
    init() {
        let px500 = PlatformConfig(name: .px, url: "https://api.500px.com/v1/", enabled: true, login: false, consumerKey: "bJIWpSFuD1lhcEzdl1Iss452mNEq4LbMEIWxV9F4", consumerSecret: "0gux5pA3HanYTr8K78KQ9pPydNvJ12Sy0rSbpypL", credentials: Credentials(), endpoints:[ Endpoint(name: .photos, parameters: ["feature":"popular", "sort":"created_at", "image_size":"2,4", "rpp":"10"])], model: nil)
        platforms = [px500]
    }
}

func compose <A, B, C> (lhs: Lens<A, B>, _ rhs: Lens<B, C>) -> Lens<A, C> {
    
    return Lens<A, C>(
        get: { a in rhs.get(lhs.get(a)) },
        set: { (c, a) in lhs.set(rhs.set(c, lhs.get(a)), a) }
    )
}

func * <A, B, C> (lhs: Lens<A, B>, rhs: Lens<B, C>) -> Lens<A, C> {
    return compose(lhs: lhs, rhs)
}
precedencegroup AnotherLensPrecedenceGroup {
    associativity: left
}

precedencegroup LensPrecedenceGroup {
    associativity: left
    higherThan: AnotherLensPrecedenceGroup
}

infix operator *~ : LensPrecedenceGroup
func *~ <A, B> (lhs: Lens<A, B>, rhs: B) -> (A) -> A {
    return { a in lhs.set(rhs, a) }
}


infix operator |> : AnotherLensPrecedenceGroup
func |> <A, B> (x: A, f: (A) -> B) -> B {
    return f(x)
}

func |> <A, B, C> (f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}


