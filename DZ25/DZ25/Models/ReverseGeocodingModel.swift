//
//  ReverseGeocodingModel.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 08.07.2021.
//

import Foundation

struct ReverseGeocoding: Codable {
    var plus_code: Global?
    var results : [Components?]
    var status: String?
}

struct Global: Codable {
    var compound_code: String?
    var global_code: String?
}

struct Components: Codable {
    var address_components : [AnotherComponants?]
    var formatted_address : String?
    var geometry : Location?
    var place_id: String?
    var plus_code: Code?
    var types: [String?]
}

struct AnotherComponants: Codable {
    var long_name: String?
    var short_name: String?
    var types : [String?]
}

struct Location: Codable {
    var bounds: North?
    var location: LatitudeLongtitude?
    var location_type: String?
    var viewport: North?
}

struct LatitudeLongtitude: Codable {
    var lat: Double?
    var lng: Double?
}

struct North: Codable {
    var northeast: LatitudeLongtitude?
    var southwest: LatitudeLongtitude?
}
   
struct Code: Codable {
    var compound_code: String?
    var global_code: String?
}

