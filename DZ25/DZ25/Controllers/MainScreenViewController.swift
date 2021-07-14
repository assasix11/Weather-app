//
//  ViewController.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 13.06.2021.
//

import UIKit
import Foundation

class MainScreenViewController: UIViewController {
    let locationManager = LocationManager.manager
    let manager = CityManager.cityManager
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forecastButton: UIButton!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var waiting: UILabel!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldCity.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        let presentForecast = UITapGestureRecognizer(target: self, action: #selector(presentionForecast))
        forecastButton.addGestureRecognizer(presentForecast)
        forecastButton.layer.cornerRadius = 10
        myLocation()
        
    }
    func changeCity(longtitudeIn: Double, latitudeIn: Double, cityName: String) {
        let cityInList: CityInList = CityInList(id: 0, name: cityName, state: "smth", country: "smth", coord: Coord(lon: longtitudeIn, lat: latitudeIn))
        CityManager.cityManager.myCity = cityInList 
        
    }
    func buildInterface(thisCity: City) {
        self.cityLabel.text = thisCity.name
        self.tempLabel.text = String(Int(thisCity.main.temp! - 273)) + "°C"
        self.humidity.text = String(thisCity.main.humidity ?? 0) + "%"
        self.windLabel.text = String(thisCity.wind.speed ?? 0) + "м/c"
        icon.image = UIImage(named: thisCity.weather[0].icon)
    }
    func makeRequest(city: String) {
        NetworkManager<City>.makeRequest(searchedCity: city) { newCity in
            guard let newCity = newCity else {
                return
            }
            DispatchQueue.main.async {
                self.buildInterface(thisCity: newCity)
            }
        }
        CityManager.cityManager.isItLocation = false
        
    }
    func myLocation() {
        locationManager.startLocation() { lat, lon in
            guard lat != nil && lon != nil else { return }
            
            let latitude = String(format: "%.2f", lat!)
            let longtitude = String(format: "%.2f", lon!)
            let string = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longtitude)&exclude=minutely,hourly&appid=a0de382efdcbfb0863066803aa31f63b"
            NetworkManager<Forecast>.makeRequest(url: string, searchedCity: "") { newDay in
                guard newDay != nil else {
                    return
                }
                DispatchQueue.main.async {
                self.tempLabel.text = String(Int((newDay?.current?.temp!)! - 273)) + "°C"
                self.humidity.text = String(newDay?.current?.humidity ?? 0) + "%"
                self.windLabel.text = String(newDay?.current?.wind_deg ?? 0) + "м/c"
                self.descriptionLabel.text = newDay?.current?.weather[0]?.description
                self.icon.image = UIImage(named: (newDay?.current?.weather[0]?.icon)!)
                
            }
            let locationString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longtitude)&key=AIzaSyDQ_8zDUIoF-47u8Dq3ZzHR3N4Jg8OBQ-c"
            NetworkManager<ReverseGeocoding>.makeRequest(url: locationString, searchedCity: "") { newDay in
                guard newDay != nil else {
                    return
                }
                DispatchQueue.main.async {
                    self.cityLabel.text = newDay?.results[0]?.address_components[3]?.long_name
                    self.locationLabel.text = (newDay?.results[0]?.address_components[3]?.long_name)! + "," + (newDay?.results[0]?.address_components[5]?.short_name)!
                    self.forecastButton.isEnabled = false
                    self.forecastButton.backgroundColor = .systemGray5
                    self.forecastButton.setTitleColor(.gray, for: .normal)
                    }
                }
                
            }
            
        }
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func presentionForecast() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Forecast", bundle: nil)
                let nextView = storyBoard.instantiateViewController(withIdentifier: "ForecastViewController") as! ForecastViewController
                self.present(nextView, animated: true, completion: nil)
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.icon.image = UIImage(data: data)
            }
        }
    }
}





