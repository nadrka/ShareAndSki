import Foundation
import MapKit

class MapViewModel {
    private var mapView: MKMapView!
    private var locationUpdater = LocationUpdaterService.sharedInstance
    var timerForUpdatingPosition = Timer()
    var timerForFriendsPosition = Timer()
    var isMapInCreatingAlertMode = false
    var users = [User]()

    var alerts = [Alert]()

    var friendsAnnotations = [FriendAnnotation]()

    func setupMapView(_ mapView: MKMapView) {
        self.mapView = mapView
    }

    func scheduleMyLocationTimer() {
        updateMyPosition()
        checkFriendLocation()
        timerForUpdatingPosition = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(updateMyPosition), userInfo: nil, repeats: true)
    }

    @objc private func updateMyPosition() {
        let latitude = mapView.userLocation.coordinate.latitude
        let longitude = mapView.userLocation.coordinate.longitude
        locationUpdater.sendMyLocationUpdate(latitude: latitude, longitude: longitude)

    }

    func scheduleFriendsLocationTimer() {
        timerForFriendsPosition = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(checkFriendLocation), userInfo: nil, repeats: true)
    }

    @objc private func checkFriendLocation() {
        locationUpdater.checkForLocationFromFriends {
            users in
            self.users = users
            self.createMarkersForFriends(users: users)
            self.checkIfSomeFriendAreNearToAlert()
        }
    }

    func createMarkersForFriends(users: [User]) {
        mapView.removeAnnotations(friendsAnnotations)
        friendsAnnotations.removeAll()
        users.forEach {
            let friendMarker = FriendAnnotation(user: $0)
            mapView.addAnnotation(friendMarker)
            friendsAnnotations.append(friendMarker)
        }
        mapView.showAnnotations(mapView.annotations, animated: true)
    }


    func showFriendOnMap(user: User) {
        if let friendAnnotation = friendsAnnotations.first(where: {
            $0.user.id == user.id
        }) {
            mapView.showAnnotations([friendAnnotation], animated: true)
        }
    }

    func toggleButton() {
        isMapInCreatingAlertMode = !isMapInCreatingAlertMode
    }

    func createAlert(locationCoordinate: CLLocationCoordinate2D) {
        let alert = Alert(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        alerts.append(alert)
        let alertAnnotation = AlertAnnotation(alert: alert)
        mapView.addAnnotation(alertAnnotation)
    }

    private func checkIfSomeFriendAreNearToAlert() {
        users.forEach({
            let user = $0
            if alerts.contains(where: {
                isDistanceBetweenFriendAndAlertLessThan50(user: user, alert: $0)
            }) {
                notifyThatSomeFriendIsNearToAlert(user)
            }
        })
    }

    private func isDistanceBetweenFriendAndAlertLessThan50(user: User, alert: Alert) -> Bool {
        let maxDistance = 50.0
        let alertLocation = CLLocation(latitude: alert.latitude, longitude: alert.longitude)
        let userLocation = CLLocation(latitude: user.latitude, longitude: user.longitude)
        let distance = userLocation.distance(from: alertLocation)
        return distance < maxDistance
    }

    private func notifyThatSomeFriendIsNearToAlert(_ user: User) {
        log.debug("\(user.nickname) is in range of the alert!")
    }
}