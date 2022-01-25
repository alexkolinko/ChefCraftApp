//
//  ClusterAnnotationView.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//

import Foundation
import MapKit

/// - Tag: ClusterAnnotationView
class ClusterAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        displayPriority = .defaultHigh
        // Offset center point to animate better with marker annotations
        centerOffset = CGPoint(x: 0, y: -10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// - Tag: CustomCluster
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let cluster = annotation as? MKClusterAnnotation else { return }
        let tototalRestaurants = cluster.memberAnnotations.count
        image = self.image(count: tototalRestaurants)
    }
    
    private func image(count: Int) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 32.0, height: 32.0))
        image = renderer.image { _ in
            UIColor.red.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)).fill()
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Metropolis-Bold", size: 14.0)!
            ]
            
            let text = count > 99 ? "99+" : "\(count)"
            let size = text.size(withAttributes: attributes)
            let rect = CGRect(x: 16 - size.width / 2, y: 16 - size.height / 2, width: size.width, height: size.height)
            text.draw(in: rect, withAttributes: attributes)
        }
        
        return image
    }
    
}
