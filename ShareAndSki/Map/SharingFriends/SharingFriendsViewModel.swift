import Foundation

class SharingFriendsViewModel {
    var friends = [Friend(name: "Gustaw Ohler", phoneNumbers: []), Friend(name: "Łukasz Pawlicki", phoneNumbers: [])]
    func getFriendThatSharesLocation(with index: Int) -> Friend {
        return friends[index]
    }

    func getNumberOfFriendsThatShareLocation() -> Int {
        return friends.count
    }
}