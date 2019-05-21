import UIKit
import MapKit
import SnapKit

class MapView: UIView, CLLocationManagerDelegate {
    private var mapView: MKMapView!
    private var alertImageView: UIImageView!
    private var viewModel: MapViewModel
    private var shouldTrackUserLocation = true
    private var locationManager = CLLocationManager()
    private var regionInMeters: Double = 1000

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupMainView()
        applyConstraints()
    }

    private func setupMainView() {
        setupMapView()
        checkLocationServices()
        setupViewModel()
        setupCreateAlertImageView()
    }

    func setupMapView() {
        mapView = MKMapView()
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressGesture.minimumPressDuration = 0.4
        mapView.addGestureRecognizer(longPressGesture)
        mapView.delegate = self
        mapView.isRotateEnabled = false
        addPanGestureRecognizerForMap()
        addSubview(mapView)
    }

    func addPanGestureRecognizerForMap() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didScrollMap))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }

    @objc func didScrollMap() {
        self.shouldTrackUserLocation = false
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            //show alert about turning on location
        }
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            zoomInLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            //SHOW ALERT
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //SHOW ALERT
            break
        case .authorizedAlways:
            break
        }
    }

    func zoomInLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(mapView.regionThatFits(region), animated: true)
        }
    }

    private func setupViewModel() {
        viewModel.setupMapView(mapView)
        viewModel.scheduleFriendsLocationTimer()
        viewModel.scheduleMyLocationTimer()
        viewModel.createMarkersForFriends(users: viewModel.users)
    }

    private func setupCreateAlertImageView() {
        let filledPickerImage = UIImage(named: "create-alert")
        let notFilledPickerImage = UIImage(named: "cancel")
        alertImageView = UIImageView(image: filledPickerImage, highlightedImage: notFilledPickerImage)
        alertImageView.isHighlighted = viewModel.isMapInCreatingAlertMode
        alertImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCreateAlertTapped))
        alertImageView.addGestureRecognizer(tapGesture)
        addSubview(alertImageView)
    }

    @objc private func onCreateAlertTapped() {
        viewModel.toggleButton()
        alertImageView.isHighlighted = viewModel.isMapInCreatingAlertMode
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }

    private func applyConstraints() {
        mapView.fillParent()

        alertImageView.snp.makeConstraints({
            make in
            make.right.equalToSuperview().inset(15.sketchHeight)
            make.top.equalTo(self.snp_topMargin).inset(30.sketchHeight)
            make.width.height.equalTo(45.sketchHeight)
        })
    }

}

extension MapView: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
    }

    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let friendAnnotation = annotation as? FriendAnnotation {
            let friendAnnotationView = FriendAnnotationView(annotation: annotation, reuseIdentifier: "", user: friendAnnotation.user)
            return friendAnnotationView
        }
        if let alertAnnotation = annotation as? AlertAnnotation {
            let alertAnnotationView = AlertAnnotationView(annotation: annotation, reuseIdentifier: "", alert: alertAnnotation.alert)
            return alertAnnotationView
        }
        return nil
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if shouldTrackUserLocation {
            mapView.setCenter((mapView.userLocation.location?.coordinate)!, animated: true)
            mapView.showAnnotations([userLocation], animated: true)
        }
    }


}

extension MapView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if !viewModel.isMapInCreatingAlertMode {
            return
        }
        if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            log.verbose("Add alert")
            viewModel.createAlert(locationCoordinate: locationCoordinate)
        }
    }
}