import Foundation
import NotificationCenter

class PhoneNumberViewModel {
    var onDoneButtonTapped: ((String) -> ())? = nil
    var onUserAlreadyRegistered: (() -> ())? = nil
    let networkManager = NetworkManager.sharedInstance
    var user: User!
    let userRepository = UserRepository.shared

    func done(phoneNumber: String) {
        let number = phoneNumber.digits
        if number.count > 6 {
            getUser(phoneNumber: number)
        }
    }

    private func getUser(phoneNumber: String) {
        if let id = userRepository.userWithToken?.user.id {
            let endpoint = String(format: Endpoints.users.rawValue, arguments: [id])
            networkManager.getArray(endpoint: Endpoints.getFullUrl(endpoint: endpoint), parameters: nil, onSuccess: {
                response in
                if let users: [User] = self.networkManager.mapResponseArray(response) {
                    let alreadyExist = self.checkIfUserAlreadyExist(users: users, phoneNumber: phoneNumber)
                    if alreadyExist {
                        self.authUser(phoneNumber: phoneNumber)
                    } else {
                        self.onDoneButtonTapped?(phoneNumber)
                    }
                }
            }, onError: {
                error in
                self.onDoneButtonTapped?(phoneNumber)
            })
        }
    }

    private func checkIfUserAlreadyExist(users: [User], phoneNumber: String) -> Bool {
        if let user = users.first(where: {
            $0.phoneNumber == phoneNumber
        }) {
            self.user = user
            return true
        }

        return false
    }

    private func authUser(phoneNumber: String) {
        let phoneNumber: PhoneNumber = PhoneNumber(number: phoneNumber)
        let endpoint = Endpoints.getFullUrl(endpoint: Endpoints.auth.rawValue)
        log.verbose("Endpoint: " + endpoint)
        networkManager.post(
                endpoint: endpoint,
                parameters: phoneNumber,
                onSuccess: {
                    response in
                    if let token: Token = self.networkManager.mapResponse(response) {
                        self.saveLoggedUserToRepository(token: token.token)
                        self.onUserAlreadyRegistered?()
                        log.debug("Authorization succes!")
                    }
                },
                onError: {
                    error in
                    log.error("Authorization error!")
                })
    }

    private func saveLoggedUserToRepository(token: String) {
        let userRepository = UserRepository()
        let userWithToken = UserWithToken(user: user, token: token)
        userRepository.save(user: userWithToken)
    }
}

