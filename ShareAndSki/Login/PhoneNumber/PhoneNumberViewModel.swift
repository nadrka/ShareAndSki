import Foundation
import NotificationCenter
class PhoneNumberViewModel {
    var onDoneButtonTapped: ((String) -> ())? = nil

    func done(phoneNumber: String) {
        let number = phoneNumber.digits
        if number.count > 6 {
            self.onDoneButtonTapped?(number)
        }
    }

    func authorize(number: String) {
//        let phoneNumber: PhoneNumber = PhoneNumber(number: "123456789")
//        log.verbose("authorize")

//        NetworkManager.sharedInstance.post(
//                endpoint: Endpoints.getFullUrl(endpoint: Endpoints.auth),
//                parameters: phoneNumber,
//                onSuccess: {
//                    [weak self] token in
//                    let tokenObject = Token(token: token)
//                },
//                onError: {
//                    error in
//                })
    }
}