//
//  RestaurantAnnotationModel.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//

import Foundation
import MapKit

class RestaurantAnnotationModel: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    @objc dynamic var title: String?
    
    var restaurantId: Int
    var isOpen: Bool

    init(location: CLLocation, restaurantId: Int, isOpen: Bool) {
        self.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.isOpen = isOpen
        title = nil
        self.restaurantId = restaurantId
        super.init()
    }
}
