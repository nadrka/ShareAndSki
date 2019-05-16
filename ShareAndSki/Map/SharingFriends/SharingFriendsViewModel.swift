import Foundation

class SharingFriendsViewModel {
    var friends = [User]()
    var onListUpdate: (()->())? = nil
    var onChosenFriend: ((User)->())? = nil
    func getFriendThatSharesLocation(with index: Int) -> User {
        return friends[index]
    }

    func getNumberOfFriendsThatShareLocation() -> Int {
        return friends.count
    }

    func listenToFriendLocationUpdate() {
        LocationUpdaterService.sharedInstance.onFriendLocationChanged = {
            [weak self] users in
            self?.friends = users
            self?.onListUpdate?()
        }
    }
}