//
//  LocationService.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 28/01/23.
//

import Foundation
import CoreLocation

class LocationService: NSObject, LocationServiceProtocol {
    private let locationManager: CLLocationManager = .init()
    private var completionHandler: ( (Result<UserExplore, Error>) -> Void )?
    private var distanceTrack: ( (Double) -> Void)?
    private var distance: Double = 0
    private var isLocationAutorized: Bool?
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    private func trackUser(locations: [CLLocation]) {
        if locations.count > 1 {
            let after: CLLocation = locations.last!
            let before: CLLocation = locations[locations.count - 2]
            
            let distanceBetween = before.distance(from: after)
            print(distanceBetween)
            distance += distanceBetween.magnitude
            print(distance)
            distanceTrack?(distance)
        }
    }
    
    func getDistance(completion: @escaping (Double) -> Void) {
        
        self.distanceTrack = completion
    }
    
    func getUserLocation(_ completion: @escaping (Result<UserExplore, Error>) -> Void) {
        self.completionHandler = completion
    }
    
    func checkLocationPermission()-> Bool? {
        isLocationAutorized
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else { return }
        let userLocation: UserExplore = .init(latitude: location.latitude, longitude: location.longitude)
        self.completionHandler?(.success(userLocation))
        self.trackUser(locations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.completionHandler?(.failure(error))
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = locationManager.authorizationStatus
        switch status {
            
        case .notDetermined, .restricted, .denied:
            self.isLocationAutorized = false
        case .authorizedAlways, .authorizedWhenInUse:
            self.isLocationAutorized = true
        @unknown default:
            print("Error")
        }
    }
}
