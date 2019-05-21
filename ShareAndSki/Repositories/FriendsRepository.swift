import Foundation


class FriendsRepository {
    private(set) var friends = [User]()
    static let sharedInstance = FriendsRepository()

    func saveFriends(_ friends: [User]) {
        self.friends = friends
    }
}