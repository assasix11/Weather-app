//
//  extensionForecast.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 30.06.2021.
//

import Foundation
import UIKit

extension ForecastViewController {
    func configure() {
        forecastView.forecastCollectionView.delegate = self
        forecastView.forecastCollectionView.dataSource = self
    }
}


extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = forecastView.forecastCollectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as! collectiCollectionViewCell
        NetworkManager<Forecast>.makeRequest(url: string, searchedCity: "") { newDay in
            guard let newDay = newDay else {
                return
            }
            DispatchQueue.main.async {
                cell.temperature.text = String(Int((newDay.daily[indexPath.item]?.temp?.morn ?? 0) - 273)) + "°C"
                cell.dayName.text = "\(self.week[self.getDayOfWeek(self.currentDate())! + indexPath.item])"
                cell.weatherDescription.text = String((newDay.daily[indexPath.item]?.weather[0]!.description)!)
                cell.icon.image = UIImage(named: newDay.daily[indexPath.item]?.weather[0]?.icon ?? "10d")
                cell.layer.cornerRadius = 10
                cell.layer.shadowOffset = CGSize(width: 0, height: 3)
                cell.layer.shadowOpacity = 0.1
                cell.layer.shadowColor = UIColor.black.cgColor
                //cell.layer.masksToBounds = false
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2 - 2, height: collectionView.bounds.width/2 - 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
