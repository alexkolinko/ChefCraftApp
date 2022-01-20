//
//  RecipeAnnotationModel.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//

import Foundation
import MapKit

class RecipeAnnotationModel: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    @objc dynamic var title: String?
    
    var terminalId: Int
    var isCooked: Bool

    init(location: CLLocation, terminalId: Int, isCooked: Bool) {
        self.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.isCooked = isCooked
        title = nil
        self.terminalId = terminalId
        super.init()
    }
}
