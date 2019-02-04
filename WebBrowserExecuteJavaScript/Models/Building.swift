//
//  Building.swift
//  WebBrowserExecuteJavaScript
//
//  Created by Maxim Kovalko on 2/4/19.
//  Copyright © 2019 Maxim Kovalko. All rights reserved.
//

struct Building: Codable {
    var description: Description?
    let price: String?
    let imagesCount: Int?
    let photos: [Photo]?
    let addTime: String?
    let updateTime: String?
    let realtyFeatures: [String]?
    let realtyProperties: RealtyProperty?
    let headerFromSource: String?
    let geo: Geo?
    let coordinates: Coordinate?
    let addTimeLabel: String?
    let updateTimeLabel: String?
}

extension Building {
    struct Geo: Codable {
        let address: Address?
        let city: Location?
        let district: Location?
        let microdistrict: Location?
    }
}

extension Building.Geo {
    struct Location: Codable {
        let name: String?
        let searchUrl: String?
    }
    
    struct Address: Codable {
        let street: Street?
        let house: String?
        //            let building: String?
    }
}

extension Building.Geo.Address {
    struct Street: Codable {
        let name: String?
        let nameFull: String?
    }
}

extension Building {
    struct Description: Codable {
        let text: String?
    }
}

extension Building {
    struct Photo: Codable {
        let title: String?
        let url: String?
        let url2x: String?
    }
}

extension Building {
    struct Coordinate: Codable {
        let longitude: Double?
        let latitude: Double?
    }
}

extension Building {
    struct RealtyProperty: Codable {
        let roomCount: Int?
        let areaTotal: Int?
        let floor: Int?
        let floorCount: Int?
    }
}
