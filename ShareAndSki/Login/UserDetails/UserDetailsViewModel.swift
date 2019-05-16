import Foundation

class UserDetailsViewModel {
    var phoneNumber: String = ""
    var onFinishButtonTapped: (() -> ())? = nil

    func validate(userName: String) {
        if userName.count >= 3 {
            checkIfUserAlreadyExist(userName: userName)
        }
    }

    private func checkIfUserAlreadyExist(userName: String) {
        let user = User(nickname: userName, phoneNumber: phoneNumber)
    }

    private func authUser() {
        self.saveLoggedUserToRepository()
        self.onFinishButtonTapped?()
    }

    private func saveLoggedUserToRepository() {

    }
}