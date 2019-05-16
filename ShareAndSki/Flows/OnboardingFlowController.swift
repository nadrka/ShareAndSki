import UIKit

class OnboardingFlowController: FlowController {

    private weak var rootNavigationController: UINavigationController?
    var onUserAlreadyLoggedIn: (()->())? = nil
    var onUserLoggedIn: (()->())? = nil

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }

    func startFlow() {
        if shouldProcessLoginFlow() {
            onUserAlreadyLoggedIn?()
        } else {
            showWelcomeScreen()
        }
    }

    func shouldProcessLoginFlow() -> Bool {
        let userRepository = UserRepository()
        return userRepository.userWithToken != nil
    }

    private func showWelcomeScreen() {
        let phoneNumberViewModel = PhoneNumberViewModel()
        let phoneNumberViewController = PhoneNumberViewController(viewModel: phoneNumberViewModel)
        phoneNumberViewModel.onDoneButtonTapped = {
            [weak self] phoneNumber in
            self?.showSmsCodeScreen(phoneNumber: phoneNumber)

        }
        rootNavigationController?.viewControllers = [phoneNumberViewController]
    }

    private func showSmsCodeScreen(phoneNumber: String) {
        let smsCodeViewModel = SmsCodeViewModel()
        smsCodeViewModel.phoneNumber = phoneNumber
        let smsCodeViewController = SmsCodeViewController(viewModel: smsCodeViewModel)
        smsCodeViewModel.onDoneButtonTapped = {
            [weak self] phoneNumber in
            self?.showUserDetailsScreen(phoneNumber: phoneNumber)
        }
        rootNavigationController?.pushViewController(smsCodeViewController, animated: true)
    }

    private func showUserDetailsScreen(phoneNumber: String) {
        let userDetailsViewModel = UserDetailsViewModel()
        userDetailsViewModel.phoneNumber = phoneNumber
        let userDetailsViewController = UserDetailsViewController(viewModel: userDetailsViewModel)
        userDetailsViewModel.onFinishButtonTapped = {
            [weak self] in
            self?.onUserLoggedIn?()
        }
        rootNavigationController?.pushViewController(userDetailsViewController, animated: true)
    }
}