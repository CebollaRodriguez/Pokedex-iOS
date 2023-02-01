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
    private var locations: [CLLocation] = []
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    private func trackUser() {
        if locations.count > 1 {
            let after: CLLocation = locations.last!
            let before: CLLocation = locations[locations.count - 2]
            
            let distanceBetween = before.distance(from: after)
            
            distance += distanceBetween.magnitude
            distanceTrack?(distance)
        }
    }
    
    func getDistance(completion: @escaping (Double) -> Void) {
        locationManager.startUpdatingLocation()
        self.distance = 0
        self.locations.removeAll()
        self.distanceTrack = completion
        
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()// falta inyectar esta funcion al explore viewmodel
    }
    
    func getUserLocation(_ completion: @escaping (Result<UserExplore, Error>) -> Void) {
        self.completionHandler = completion
    }
    
    func checkLocationPermission()-> Bool? {
        isLocationAutorized
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last?.coordinate else { return }
        let userLocation: UserExplore = .init(latitude: location.latitude, longitude: location.longitude)
        self.completionHandler?(.success(userLocation))
        self.locations.append(locations.last!)
        self.trackUser()
        if self.distance > 100 {
            self.distance = 0
            self.locations.removeAll()
        }
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
