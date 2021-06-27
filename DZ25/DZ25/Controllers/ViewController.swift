//
//  ViewController.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 13.06.2021.
//

import UIKit
import Foundation

class ViewController: UIViewController {
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
        makeRequest(city: "london")
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func buildInterface(thisCity: City) {
        self.cityLabel.text = "Город:" + " " + thisCity.name
        self.tempLabel.text = "Температура:" + " " + String(Int(thisCity.main.temp! - 273)) + "°C"
        self.humidity.text = "Влажность:" + " " + String(thisCity.main.humidity ?? 0) + "%"
        self.windLabel.text = "Ветер:" + " " + String(thisCity.wind.speed ?? 0) + "м/c"
        let url = URL(string: "https://openweathermap.org/img/w/\(thisCity.weather[0].icon).png")!
        downloadImage(from: url)
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
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
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


extension ViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        var inputCity = textField.text!.lowercased()
        while inputCity.last == " " {
            inputCity.removeLast()
        }
        NetworkManager<City>.makeRequest(searchedCity: inputCity) { newCity in
            guard let newCity = newCity else {
                DispatchQueue.main.async {
                self.waiting.text = "Город не найден"
                self.waiting.textColor = .red
                }
                return
            }
            DispatchQueue.main.async {
                self.waiting.text = "Город найден"
                self.waiting.textColor = .green
                self.buildInterface(thisCity: newCity)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


