//
//  CityManager .swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 29.06.2021.
//

import Foundation

class CityManager {
    static let cityManager = CityManager()
    var myCity: CityInList?
    var chosenCity: String?
    func parceTheCity() -> String {
        guard myCity != nil else {
            return "https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=minutely,hourly&appid=a0de382efdcbfb0863066803aa31f63b"
        }
        let lat = String(format: "%.2f", myCity!.coord.lat)
        let lon = String(format: "%.2f", myCity!.coord.lon)
        print(lat)
        let string = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly&appid=a0de382efdcbfb0863066803aa31f63b"
        return string
    }
}
