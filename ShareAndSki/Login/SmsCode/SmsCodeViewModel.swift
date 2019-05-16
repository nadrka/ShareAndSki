import Foundation

class SmsCodeViewModel {
    var phoneNumber: String = ""
    var onDoneButtonTapped: ((String)->())? = nil
    final let code = "111111"
    func validate(code: String) {
        if self.code == code {
            onDoneButtonTapped?(phoneNumber)
        }
    }
}