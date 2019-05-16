import Foundation

class LocationUpdaterService {

    func checkForLocationFromFriends(completionHandler: @escaping ([User]) -> ()) {
        //todo: GET users/{id}/knownUsers
    }

    func sendMyLocationUpdate(latitude: Double, longitude: Double) {
        //todo: PUT users/{id}/position
    }
}