//
//  MapView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 28/01/23.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    @Binding var userExplore: UserExplore
    @Binding var isLocationEnable: Bool
    typealias UIViewType = GMSMapView
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: userExplore.latitude, longitude: userExplore.longitude, zoom: 10)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.settings.indoorPicker  = false
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        GMSCameraPosition.camera(withLatitude: userExplore.latitude, longitude: userExplore.longitude, zoom: 13)
        
        
    } 
    
    
}

class MapDelegate: NSObject, GMSMapViewDelegate {
    
}
