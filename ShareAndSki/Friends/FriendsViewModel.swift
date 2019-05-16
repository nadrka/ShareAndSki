import Foundation
import ContactsUI

class FriendsViewModel {
    var friends = [Friend]()
    var friendsFromApp = [User]()
    var onListUpdated: (() -> ())? = nil
    var onLoading: ((Bool)->())? = nil

    init() {

    }

    func checkForUserFromContacts() {
        friends = phoneContactsMapped()
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
                    return $0.value.stringValue
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
    }

    private func getUsers(completionHandler: @escaping (([User]) -> ())) {

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


}