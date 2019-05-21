import Foundation

class CreateGroupViewModel {
    var friends = FriendsRepository.sharedInstance.friends
    var onGroupCreated: (() -> ())? = nil
    var cellViewModels: [DefaultFriendCellViewModel] = []
    let networkManager = NetworkManager.sharedInstance
    let userRepository = UserRepository()

    func getNumberOfFriends() -> Int {
        return friends.count
    }

    func getFriend(for index: Int) -> User {
        return friends[index]
    }

    func onCreateGroupTapped(name: String) {
        if name.count < 3 {
            log.error("Group name is too short! < 3")
            return
        }
        let chosenFriends = cellViewModels.filter({
            $0.isSelected == true
        }).map {
            return $0.friend
        }

        createGroup(name: name, friends: chosenFriends)
    }

    func createGroup(name: String, friends: [User]) {
        let endpoint = Endpoints.groups.rawValue
        let group = Group(name: name)
        NetworkManager.sharedInstance.post(endpoint: Endpoints.getFullUrl(endpoint: endpoint), parameters: group, onSuccess: {
            [weak self] result in
            if let group: Group = self?.networkManager.mapResponse(result) {
                self?.updateUsersForGroup(groupId: group.id, friends: friends)
            }
        }, onError: {
            error in
            log.error("error while creating group! \(error.description)")
        })
    }

    func updateUsersForGroup(groupId: Int, friends: [User]) {
        friends.forEach({
            addUserToGroup(groupId: groupId, friendId: $0.id)
        })
        onGroupCreated?()
    }

    func addUserToGroup(groupId: Int, friendId: Int) {
        let endpoint = String(format: Endpoints.userForGroup.rawValue, arguments: [String(groupId)])
        let fid = FriendId(id: friendId)
        NetworkManager.sharedInstance.post(endpoint: Endpoints.getFullUrl(endpoint: endpoint), parameters: fid, onSuccess: {
            [weak self] user in
        }, onError: {
            error in
        })
    }
}