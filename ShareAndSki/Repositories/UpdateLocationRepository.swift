import Foundation

class UpdateLocationRepository {
    static let sharedInstance = UpdateLocationRepository()
    private var groupsToShare: [Int] = []
    private var friendsToShare: [Int] = []

    func insertGroupToShare(id: Int) {
        groupsToShare.append(id)
    }

    func insertFriendToShare(id: Int) {
        friendsToShare.append(id)
    }

    func removeGroupToShare(id: Int) {
        if let index = groupsToShare.firstIndex(of: id) {
            groupsToShare.remove(at: index)
        }
    }

    func removeFriendToShare(id: Int) {
        if let index = groupsToShare.firstIndex(of: id) {
            friendsToShare.remove(at: index)
        }
    }

    func shouldUpdatePosition() -> Bool {
        return friendsToShare.count > 0 || groupsToShare.count > 0
    }
}