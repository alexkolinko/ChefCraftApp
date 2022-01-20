//
//  RecipesMapViewController.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//  
//

import RxCocoa
import RxSwift
import MapKit
import RxMKMapView

class RecipesMapViewController: UIViewController, StoryboardInitializable {

    // - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // - Internal properties
    var presenter: RecipesMapPresenterImpl!

    // - Private properties
    private var disposeBag = DisposeBag()
    private var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter.selectedTerminal.accept(nil)
    }
    
    deinit {
        print("---> deinit \(self)")
    }

    // - UI Setup
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.configureMapView()
    }
    
    private func configureMapView() {
        locationManager.delegate = self
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.delegate = self
        mapView.showsCompass = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        mapView.register(RecipeAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(RecipeAnnotationModel.self))
        mapView.register(ClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        let authorizationStatus: CLAuthorizationStatus

        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }

        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            self.presenter.isLocationServicesEnabled.accept(true)
        default:
            self.presenter.isLocationServicesEnabled.accept(false)
        }
    }

    // - Binding Setup
    private func setupBinding() {
        
        // - Map view bindings
        self.presenter.recipes
            .asDriver()
            .map { terminals -> [RecipeAnnotationModel] in
                let annotations: [RecipeAnnotationModel] = terminals.compactMap({
                    .init(
                        location: CLLocation(
                            latitude: CLLocationDegrees($0.latitude),
                            longitude: CLLocationDegrees($0.longitude)
                        ),
                        terminalId: Int($0.id) ?? 0,
                        isCooked: $0.cooked
                    )
                })
                return annotations
            }
            .drive(mapView.rx.annotations)
            .disposed(by: self.disposeBag)
        
        self.mapView.rx.didSelectAnnotationView
            .asDriver()
            .drive(onNext: { [weak self] selectedView in
                self?.mapView.deselectAnnotation(selectedView.annotation, animated: true)
                
                if let cluster = selectedView.annotation as? MKClusterAnnotation {
                    self?.mapView.showAnnotations(cluster.memberAnnotations, animated: true)
                } else if let model = selectedView.annotation as? RecipeAnnotationModel {
                    self?.presenter.selectTerminal(with: model.terminalId)
                }
                
            })
            .disposed(by: self.disposeBag)
 
    }

    // - Location Actions
    private func centerMapOnUserLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            guard let coordinate = locationManager.location?.coordinate else { return }
            let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
            self.presenter.isLocationServicesEnabled.accept(true)
        default:
            self.presenter.isLocationServicesEnabled.accept(false)
            self.showPermissionDeclineWarning(with: "Ви не надали доступу до вашої геолокації. Деякий функціонал, що використовує геолокацію користувача, може бути не доступним. Для використання цього функціоналу, будь ласка, надайте доступ до вашого місцезнаходження")
        }
    }
}

// MARK: - RecipesMapViewController: CLLocationManagerDelegate
extension RecipesMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                centerMapOnUserLocation()
            default:
                break
            }
            
        }
}

// MARK: - RecipesMapViewController: MKMapViewDelegate
extension RecipesMapViewController: MKMapViewDelegate {
    
    /// The map view asks `mapView(_:viewFor:)` for an appropiate annotation view for a specific annotation.
    ///  - Tag: CreateAnnotationViews
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        if annotation is MKClusterAnnotation {
            return nil
        }
        
        if let annotation = annotation as? RecipeAnnotationModel {
            let reuseIdentifier = NSStringFromClass(RecipeAnnotationModel.self)
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation) as? RecipeAnnotationView
            annotationView?.isCooked = annotation.isCooked
            annotationView?.clusteringIdentifier = NSStringFromClass(ClusterAnnotationView.self)
            annotationView?.canShowCallout = false
            annotationView?.isDraggable = false
            return annotationView
        } else {
            return nil
        }
    }
}
