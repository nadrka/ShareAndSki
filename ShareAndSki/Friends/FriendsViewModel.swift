import Foundation
import ContactsUI

class FriendsViewModel {
    var friends = [Friend]()
    var friendsFromApp = [User]()
    var onListUpdated: (() -> ())? = nil
    var onLoading: ((Bool) -> ())? = nil
    var userRepository = UserRepository()
    let networkManager = NetworkManager.sharedInstance

    init() {

    }

    func checkForUserFromContacts() {
        friends = phoneContactsMapped()
        fetchUserFromContacts()
    }

    private func phoneContactsMapped() -> [Friend] {
        onLoading?(true)
        let contactStore = CNContactStore()
        var friends = [Friend]()
        let keys = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey
        ] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        request.sortOrder = .givenName
        do {
            log.debug("Read phone contacts succeed.")
            try contactStore.enumerateContacts(with: request) {
                (phoneContact, stop) in
                // unfortunately, there is no display name property in CNContact
                let name = phoneContact.givenName + " " + phoneContact.familyName
                let phoneNumbers = phoneContact.phoneNumbers.compactMap {
                    return $0.value.stringValue.digits
                }
                let friend = Friend(name: name, phoneNumbers: phoneNumbers)
                friends.append(friend)

            }
        } catch {
            onLoading?(false)
            log.error("Read phone contacts failed. Probably user didn't provide the access to contacts")
        }
        onLoading?(false)
        return friends
    }

    private func fetchUserFromContacts() {
        getUsers(completionHandler: {
            users in
            users.forEach {
                self.checkIfUserMatchOurContacts(user: $0)
            }
            self.onListUpdated?()
        })

        sendMyFriendsToServer()
    }

    private func getUsers(completionHandler: @escaping (([User]) -> ())) {
        if let id = userRepository.userWithToken?.user.id {
            let endpoint = String(format: Endpoints.users.rawValue, arguments: [id])
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

    private func checkIfUserMatchOurContacts(user: User) {
        let friend = friends.first(where: {
            $0.phoneNumbers.contains(user.phoneNumber)
        })

        if let matchingContact = friend {
            user.nameFromContactList = matchingContact.name
            friendsFromApp.append(user)
        }

    }

    private func sendMyFriendsToServer() {
        friendsFromApp.forEach {
            self.sendFriend(friendId: $0.id)
        }
    }

    private func sendFriend(friendId: Int) {
        if let id = userRepository.userWithToken?.user.id {
            let endpoint = String(format: Endpoints.usersFriends.rawValue, arguments: [id])
            let fid = FriendId(id: id)
            NetworkManager.sharedInstance.post(endpoint: Endpoints.getFullUrl(endpoint: endpoint), parameters: fid, onSuccess: {
                [weak self] user in
            }, onError: {
                error in
            })
        }
    }


}