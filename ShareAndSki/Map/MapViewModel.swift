import Foundation
import MapKit

class MapViewModel {
    private var mapView: MKMapView!
    private var locationUpdater = LocationUpdaterService.sharedInstance
    var timerForUpdatingPosition = Timer()
    var timerForFriendsPosition = Timer()
    let users = [
        User(nickname: "Dżasta", phoneNumber: "123213", longitude: 18.653242, latitude: 54.349822),
        User(nickname: "Braniak", phoneNumber: "123123", longitude: 18.653394, latitude: 54.348850),
        User(nickname: "Julian", phoneNumber: "12312", longitude: 18.653216, latitude:54.348628)
    ]
    
    let friendsAnnotations = [FriendAnnotation]()

    func setupMapView(_ mapView: MKMapView) {
        self.mapView = mapView
    }

    func scheduleMyLocationTimer() {
        timerForUpdatingPosition = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(updateMyPosition), userInfo: nil, repeats: true)
    }

    @objc private func updateMyPosition() {
        if UpdateLocationRepository.sharedInstance.shouldUpdatePosition() {
            let latitude = mapView.userLocation.coordinate.latitude
            let longitude = mapView.userLocation.coordinate.longitude
            locationUpdater.sendMyLocationUpdate(latitude: latitude, longitude: longitude)
        }
    }

    func scheduleFriendsLocationTimer() {
        timerForFriendsPosition = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(checkFriendLocation), userInfo: nil, repeats: true)
    }

    @objc private func checkFriendLocation() {
        locationUpdater.checkForLocationFromFriends {
            users in
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.createMarkersForFriends(users: users)
        }
    }

    func createMarkersForFriends(users: [User]) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        users.forEach {
            let friendMarker = FriendAnnotation(user: $0)
            mapView.addAnnotation(friendMarker)
        }
        mapView.showAnnotations(mapView.annotations, animated: true)
    }


    func showFriendOnMap(user: User) {
        //todo: move map to a friend location
    }

}