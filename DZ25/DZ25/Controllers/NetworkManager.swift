//
//  NetworkManager.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 13.06.2021.
//

import Foundation

class NetworkManager<T: Codable> {
    class func makeRequest(url: String? = nil, searchedCity: String, completion: @escaping(T?) -> ()) {
        var string = "https://api.openweathermap.org/data/2.5/weather?q=\(searchedCity)&appid=a0de382efdcbfb0863066803aa31f63b"
        if (url != nil) {
            string = url!
        }
        print(string)
        guard let url = URL(string: string) else {
            print(URL(string: string))
            print("invalid url")
            return
        }
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(error)
                return
            }
            let city = try? JSONDecoder().decode(T.self, from: data)
            completion(city)
    }
        dataTask.resume()
    }
}
