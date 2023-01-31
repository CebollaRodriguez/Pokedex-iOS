//
//  LocationServiceProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 28/01/23.
//

import Foundation

protocol LocationServiceProtocol: AnyObject {
    func getUserLocation(_ completion: @escaping (Result<UserExplore, Error>) -> Void)
    
    func checkLocationPermission()-> Bool?
    
    func getDistance(completion: @escaping (Double) -> Void)
}
