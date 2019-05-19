import Foundation

class UserDetailsViewModel {
    var phoneNumber: String = ""
    var onFinishButtonTapped: (() -> ())? = nil
    var user: User!
    let networkManager = NetworkManager.sharedInstance

    func validate(userName: String) {
        if userName.count >= 3 {
            checkIfUserAlreadyExist(userName: userName)
        }
    }

    private func checkIfUserAlreadyExist(userName: String) {
        let user = User(nickname: userName, phoneNumber: phoneNumber)
        let endpoint = Endpoints.getFullUrl(endpoint: Endpoints.users.rawValue)
        log.verbose("Endpoint: " + endpoint)
        networkManager.post(
                endpoint: endpoint,
                parameters: user,
                onSuccess: {
                    response in
                    self.user = self.networkManager.mapResponse(response)
                    log.debug("Creating account succes!")
                    self.authUser()
                },
                onError: {
                    error in
                    log.error("Creating account error!")
                })
    }

    private func authUser() {
        let phoneNumber: PhoneNumber = PhoneNumber(number: self.phoneNumber)
        let endpoint = Endpoints.getFullUrl(endpoint: Endpoints.auth.rawValue)
        log.verbose("Endpoint: " + endpoint)
        networkManager.post(
                endpoint: endpoint,
                parameters: phoneNumber,
                onSuccess: {
                    response in
                    if let token: Token = self.networkManager.mapResponse(response) {
                        self.saveLoggedUserToRepository(token: token.token)
                        self.onFinishButtonTapped?()
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