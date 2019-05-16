import Foundation
import MapKit

class MapViewModel {
    private var mapView: MKMapView!
    private var locationUpdater = LocationUpdaterService()
    var timerForUpdatingPosition = Timer()
    var timerForFriendsPosition = Timer()

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
            users.forEach {
                //todo: create marker on map for each user
                $0
            }
        }
    }


}