import Foundation

class SharingFriendsViewModel {
    var friends = [User]()
    func getFriendThatSharesLocation(with index: Int) -> User {
        return friends[index]
    }

    func getNumberOfFriendsThatShareLocation() -> Int {
        return friends.count
    }
}