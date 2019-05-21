import Foundation

class GroupViewModel {
    var groups = [Group]()
    var onCreateButtonTapped: (() -> ())? = nil
    var onListUpdated: (() -> ())? = nil
    let networkManager = NetworkManager.sharedInstance
    let userRepository = UserRepository()

    func fetchGroups() {
        let endpoint = Endpoints.groups.rawValue
        networkManager.getArray(endpoint: Endpoints.getFullUrl(endpoint: endpoint), parameters: nil, onSuccess: {
            [weak self] response in
            if let groups: [Group] = self?.networkManager.mapResponseArray(response) {
                self?.groups = groups
                self?.onListUpdated?()
            }
        }, onError: {
            error in
        })
    }


}
