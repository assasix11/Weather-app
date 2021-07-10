//
//  cityListModel.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 29.06.2021.
//

import Foundation

struct CityInList: Codable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: Coord
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}
