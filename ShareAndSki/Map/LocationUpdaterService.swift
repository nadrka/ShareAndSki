import Foundation

class LocationUpdaterService {

    static let sharedInstance = LocationUpdaterService()

    var onFriendLocationChanged: (([User])->())? = nil

    func checkForLocationFromFriends(completionHandler: @escaping ([User]) -> ()) {
        //todo: GET users/{id}/knownUsers
    }

    func sendMyLocationUpdate(latitude: Double, longitude: Double) {
        //todo: PUT users/{id}/position
    }
}