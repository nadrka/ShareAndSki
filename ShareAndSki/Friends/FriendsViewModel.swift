import Foundation
import ContactsUI

class FriendsViewModel {
    var friends = [Friend]()
    var onListUpdated: (() -> ())? = nil

    init() {

    }

    func checkForUserFromContacts() {
        friends = phoneContactsMapped()
        fetchUserFromContacts(friends: friends)
    }

    private func phoneContactsMapped() -> [Friend] {
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
            log.error("Read phone contacts failed. Probably user didn't provide the access to contacts")
        }
        return friends
    }

    private func fetchUserFromContacts(friends: [Friend]) {
        onListUpdated?()
    }
}