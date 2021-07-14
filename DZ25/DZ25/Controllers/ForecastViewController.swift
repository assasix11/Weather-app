//
//  ForecastViewController.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 27.06.2021.
//

import UIKit

class ForecastViewController: UIViewController {
    let week = ["Sunday", "Monday", "Tusday", "Wednesday", "Thursday", "Friday", "Saturday","Sunday", "Monday", "Tusday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let date = Date()
    let manager = CityManager.cityManager
    var forecast : Forecast!
    var string = CityManager.cityManager.parceTheCity()
    var forecastView: ForecastView! {
         guard isViewLoaded else { return nil }
         return (view as! ForecastView)
    }
    override func viewDidLoad() {
        configure()
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: forecastView.bounds.width/2 - 5, height: forecastView.bounds.width/2 - 5)
        forecastView.forecastCollectionView.collectionViewLayout = layout
        forecastView.forecastCollectionView.register(UINib(nibName: "collectiCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "forecastCell")
        forecastView.cityName.text = (CityManager.cityManager.chosenCity ?? "City") + ": " + "7 days weather forecast"
        makeActivityIndicator()
    }
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    func currentDate() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        return dateFormatterPrint.string(from: date)
    }
    func makeActivityIndicator() {
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = view.center
        ai.startAnimating()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        blurEffectView.alpha = 0.75
        view.addSubview(ai)
        var timerStop = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            guard timerStop == 0 else { return }
            if self.manager.myCity != nil && self.manager.chosenCity != nil {
                if self.manager.myCity!.name.lowercased() == self.manager.chosenCity!.lowercased() {
                    reload()
                    timerStop = 1
                    ai.removeFromSuperview()
                    blurEffectView.removeFromSuperview()
                }
            }
  
        }
        func reload() {
            forecastView.forecastCollectionView.reloadData()
            forecastView.cityName.text = (CityManager.cityManager.chosenCity ?? "City") + ": " + "7 days weather forecast"
        }
    }
}



 
