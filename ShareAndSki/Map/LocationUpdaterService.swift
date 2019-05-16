import Foundation

class LocationUpdaterService {

    static let sharedInstance = LocationUpdaterService()
    var onFriendLocationChanged: (([User]) -> ())? = nil
    var userRepository = UserRepository()
    let networkManager = NetworkManager.sharedInstance

    func checkForLocationFromFriends(completionHandler: @escaping ([User]) -> ()) {
        if let id = userRepository.userWithToken?.user.id {
            let endpoint = String(format: Endpoints.knownUsers.rawValue, arguments: [id])
            networkManager.getArray(endpoint: Endpoints.getFullUrl(endpoint: endpoint), parameters: nil, onSuccess: {
                        [weak self] response in
                        if let users: [User] = self?.networkManager.mapResponseArray(response) {
                            completionHandler(users)
                        }
                    }, onError: {
                        error in
                    })
        }

    }

    func sendMyLocationUpdate(latitude: Double, longitude: Double) {
        if let user = userRepository.userWithToken?.user {
            let id = user.id
            let position = Position(longitude: user.longitude, latitude: user.latitude)
            let endpoint = String(format: Endpoints.userPosition.rawValue, arguments: [id])
            NetworkManager.sharedInstance.put(endpoint: Endpoints.getFullUrl(endpoint: endpoint), parameters: position, onSuccess: {
                [weak self] result in
            }, onError: {
                error in
            })
        }
    }
}