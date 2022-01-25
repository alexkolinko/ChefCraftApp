//
//  RestaurantAnnotationView.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//

import Foundation
import MapKit
import UIKit

class RestaurantAnnotationView: MKAnnotationView {
    
    public var isOpen: Bool = false {
        didSet {
            self.image = self.setRestaurantImage()
        }
    }
    
    var isSelectedRestaurant: Bool = false {
        willSet {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            let workIcon = UIImage(named: "selectedMarker")
            self.image = newValue ? workIcon : self.setRestaurantImage()
            CATransaction.commit()
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = NSStringFromClass(ClusterAnnotationView.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setRestaurantImage() -> UIImage? {
        return self.isOpen == true ? UIImage(named: "openMarker") : UIImage(named: "closeMarker")
    }
}
