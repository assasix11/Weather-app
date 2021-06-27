//
//  OneCityModel.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 25.06.2021.
//

import Foundation

struct OneCity {
    let id: Int
    let name: String
    let state: String
    let coord: Coord
}

struct Coord {
    let lon: Double
    let lat: Double
}
