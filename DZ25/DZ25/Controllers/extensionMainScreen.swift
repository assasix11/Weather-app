//
//  extensionMainScreen.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 04.07.2021.
//

import Foundation
import UIKit

extension MainScreenViewController : UITextFieldDelegate {
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
                self.manager.chosenCity = inputCity
                self.forecastButton.isEnabled = true
                self.forecastButton.backgroundColor = .systemYellow
                self.forecastButton.setTitleColor(.black, for: .normal)
            }
        }
        DispatchQueue.global(qos: .userInitiated).async {
        let findedCity = self.localRequest()!
        if let citiie = findedCity.first(where: { $0.name.lowercased() == inputCity }) {
                DispatchQueue.main.async {
                   self.manager.myCity = citiie
                    self.manager.chosenCity = citiie.name
                }
            }
        }
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func localRequest() -> [CityInList]? {
        guard let path = Bundle.main.path(forResource: "city.list", ofType: "json") else { return nil }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return nil }
        let city = try? JSONDecoder().decode([CityInList].self, from: data)
        return city
    }

}
