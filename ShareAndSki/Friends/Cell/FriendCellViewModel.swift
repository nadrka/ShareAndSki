import Foundation

enum FriendCellUsage {
    case friendsToShareLocation
    case friendsSharingLocation
    case friendsPicker
}

protocol FriendCellViewModel {
    var isDistanceLabelHidden: Bool { get }
    var isLocationSharingButtonHidden: Bool { get }
    var isPickerHidden: Bool { get }
    var initials: String { get }
    var name: String { get }
    func toggleButton()
}

class DefaultFriendCellViewModel: FriendCellViewModel {
    private(set) var isSelected: Bool = false
    private(set) var friend: Friend
    private var cellUsage: FriendCellUsage

    init(cellUsage: FriendCellUsage, friend: Friend) {
        self.cellUsage = cellUsage
        self.friend = friend
    }

    var isDistanceLabelHidden: Bool {
        switch cellUsage {
        case .friendsToShareLocation:
            return true
        default:
            return false

        }
    }

    var isLocationSharingButtonHidden: Bool {
        switch cellUsage {
        case .friendsSharingLocation:
            return true
        default:
            return false
        }
    }

    var isPickerHidden: Bool {
        return false
    }

    func toggleButton() {
        isSelected = !isSelected
    }

    var initials: String {
        let name = friend.name
        let initials = InitialCreator.getInitials(from: name)
        return initials
    }

    var name: String {
        return friend.name
    }
}