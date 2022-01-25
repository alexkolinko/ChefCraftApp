//
//  RestaurantsMapViewController.swift
//  ChefCraftApp
//
//  Created by Work on 17.01.2022.
//  
//

import RxCocoa
import RxSwift
import MapKit
import RxMKMapView

class RestaurantsMapViewController: UIViewController, StoryboardInitializable {

    // - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var restaurantDetailedInfoBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var restaurantDetailView: RestaurantDetailView!
    
    @IBOutlet weak var userLocationContainer: CorneredView!
    @IBOutlet weak var userLocationButton: UIButton!
    
    // - Internal properties
    var presenter: RestaurantsMapPresenterImpl!

    // - Private properties
    private var disposeBag = DisposeBag()
    private var locationManager = CLLocationManager()

    private var defeaultBottomConstraintValue: CGFloat {
        let min = self.restaurantDetailView.bounds.height
        return min
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.centerMapOnUserLocation()
    }
    
    deinit {
        print("---> deinit \(self)")
    }

    // - UI Setup
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.configureMapView()
        self.configureButtons()
    }
    
    private func configureButtons() {
        self.userLocationContainer.layer.borderWidth = 1.0
        self.userLocationContainer.layer.borderColor = UIColor.gray.cgColor
    }
    
    private func configureMapView() {
        locationManager.delegate = self
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.delegate = self
        mapView.showsCompass = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        mapView.register(RestaurantAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(RestaurantAnnotationModel.self))
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
        self.presenter.restaurants
            .asDriver()
            .map { restaurants -> [RestaurantAnnotationModel] in
                let annotations: [RestaurantAnnotationModel] = restaurants.compactMap({
                    .init(
                        location: CLLocation(
                            latitude: CLLocationDegrees($0.latitude),
                            longitude: CLLocationDegrees($0.longitude)
                        ),
                        restaurantId: Int($0.id) ?? 0,
                        isOpen: $0.isOpen
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
                } else if let model = selectedView.annotation as? RestaurantAnnotationModel {
                    self?.presenter.selectRestaurant(with: model.restaurantId)
                }
                
            })
            .disposed(by: self.disposeBag)
        
        // - Presenter + selectedRestaurant bindings
        self.presenter.selectedRestaurant
            .withPrevious(startWith: nil)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] previos, next in
                if
                    let previosAnnotation = self?.mapView.annotations.first(where: { ($0 as? RestaurantAnnotationModel)?.restaurantId.getString() == previos?.id }),
                    let previosAnnotationView = self?.mapView.view(for: previosAnnotation) as? RestaurantAnnotationView
                {
                    previosAnnotationView.isSelectedRestaurant = false
                }
                
                if
                    let nextSelectedAnnotation = self?.mapView.annotations.first(where: { ($0 as? RestaurantAnnotationModel)?.restaurantId.getString() == next?.id }),
                    let nextAnnotationView = self?.mapView.view(for: nextSelectedAnnotation) as? RestaurantAnnotationView
                {
                    self?.mapView.showAnnotations([nextSelectedAnnotation], animated: true)
                    nextAnnotationView.isSelectedRestaurant = true
                }
                
                self?.restaurantDetailView.restaurantShowing.accept(next)
            })
            .disposed(by: self.disposeBag)
        
        self.userLocationButton.rx.tap
            .asDriver()
            .throttle(.milliseconds(300), latest: false)
            .drive(onNext: { [weak self] in
                self?.centerMapOnUserLocation()
            })
            .disposed(by: self.disposeBag)
        
        self.restaurantDetailView.restaurantShowing
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] selectedRestaurant in
                self?.restaurantDetailedInfoBottomConstraint.constant = selectedRestaurant != nil ? 0.0 : self?.defeaultBottomConstraintValue ?? 0.0
                UIView.animate(withDuration: 0.3) {
                    self?.view.layoutIfNeeded()
                }
            })
            .disposed(by: self.disposeBag)
        
        self.restaurantDetailView.dissmisView
            .subscribe(onNext: { [weak self] in
                self?.presenter.selectedRestaurant.accept(nil)
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

// MARK: - RestaurantsMapViewController: CLLocationManagerDelegate
extension RestaurantsMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                centerMapOnUserLocation()
            default:
                break
            }

        }
}

// MARK: - RestaurantsMapViewController: MKMapViewDelegate
extension RestaurantsMapViewController: MKMapViewDelegate {

    /// The map view asks `mapView(_:viewFor:)` for an appropiate annotation view for a specific annotation.
    ///  - Tag: CreateAnnotationViews
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        if annotation is MKClusterAnnotation {
            return nil
        }

        if let annotation = annotation as? RestaurantAnnotationModel {
            let reuseIdentifier = NSStringFromClass(RestaurantAnnotationModel.self)
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation) as? RestaurantAnnotationView
            annotationView?.isOpen = annotation.isOpen
            annotationView?.clusteringIdentifier = NSStringFromClass(ClusterAnnotationView.self)
            annotationView?.canShowCallout = false
            annotationView?.isDraggable = false
            return annotationView
        } else {
            return nil
        }
    }
}
