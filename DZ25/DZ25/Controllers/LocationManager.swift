//
//  LocationManager.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 07.07.2021.
//

import Foundation
import CoreLocation

class LocationManager : NSObject {
    var locationManager : CLLocationManager?
    static let manager = LocationManager()
    func startLocation(completion: @escaping(Double?, Double?) -> ()) {
        locationManager = CLLocationManager()
        self.locationManager?.requestAlwaysAuthorization()
        self.locationManager?.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
            let lattitude = locationManager?.location?.coordinate.latitude
            let longtitude = locationManager?.location?.coordinate.longitude
            completion(lattitude, longtitude)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    }
}
