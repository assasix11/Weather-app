//
//  OneCityModel.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 25.06.2021.
//

import Foundation

struct Forecast: Codable {
    let lat: Double?
    let lon: Double?
    let timezone: String?
    let timezone_offset: Int?
    let current: Current?
    let daily: [Daily?]
    
}

struct Current: Codable {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let temp: Double?
    let feels_like: Double?
    let pressure: Int?
    let humidity: Int?
    let dew_point: Double?
    let uvi: Double?
    let clouds: Int?
    let visibility: Int?
    let wind_speed: Double?
    let wind_deg: Int?
    let wind_gust: Double?
    let weather: [Weather?]
    let rain: Rain?
}

struct Rain: Codable {
    let hour: Double?
    
    enum CodingKeys: String, CodingKey {
        case hour = "1h"
    }
}

struct Daily: Codable {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let moonrise: Int?
    let moonset: Int?
    let moon_phase: Double?
    let temp: Temp?
    let feels_like: Feel?
    let pressure: Int?
    let humidity: Int?
    let dew_point: Double?
    let wind_speed: Double?
    let wind_deg: Int?
    let wind_gust: Double?
    let weather: [Weather?]
    let clouds: Int?
    let pop: Double?
    let uvi: Double?
}

struct Temp: Codable {
    let day: Double?
    let min: Double?
    let max: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

struct Feel: Codable{
    let day: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

