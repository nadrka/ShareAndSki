import Foundation

class LocationUpdaterService {

    static let sharedInstance = LocationUpdaterService()
    var onFriendLocationChanged: (([User]) -> ())? = nil
    var userRepository = UserRepository()
    let networkManager = NetworkManager.sharedInstance

    func checkForLocationFromFriends(completionHandler: @escaping ([User]) -> ()) {
        if let id = userRepository.userWithToken?.user.id {
            let endpoint = String(format: Endpoints.knownUsers.rawValue, arguments: [String(id)])
            networkManager.getArray(endpoint: Endpoints.getFullUrl(endpoint: endpoint), parameters: nil, onSuccess: {
                        [weak self] response in
                        if let users: [User] = self?.networkManager.mapResponseArray(response) {
                            completionHandler(users)
                            self?.onFriendLocationChanged?(users)
                        }
                    }, onError: {
                        error in
                    })
        }

    }

    func sendMyLocationUpdate(latitude: Double, longitude: Double) {
        if let user = userRepository.userWithToken?.user {
            let id = user.id
            let position = Position(longitude: longitude, latitude: latitude)
            let endpoint = String(format: Endpoints.userPosition.rawValue, arguments: [String(id)])
            NetworkManager.sharedInstance.put(endpoint: Endpoints.getFullUrl(endpoint: endpoint), parameters: position, onSuccess: {
                [weak self] result in
            }, onError: {
                error in
            })
        }
    }
}