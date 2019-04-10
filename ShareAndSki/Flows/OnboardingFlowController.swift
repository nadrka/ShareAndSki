import UIKit

class OnboardingFlowController: FlowController {

    private weak var rootNavigationController: UINavigationController?
    private var isLoggedIn: Bool = false
    var onUserAlreadyLoggedIn: (()->())? = nil
    var onUserLoggedIn: (()->())? = nil

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }

    func startFlow() {
        if isLoggedIn {
            onUserAlreadyLoggedIn?()
        } else {
            showWelcomeScreen()
        }
    }

    private func showWelcomeScreen() {
        let phoneNumberViewModel = PhoneNumberViewModel()
        let phoneNumberViewController = PhoneNumberViewController(viewModel: phoneNumberViewModel)
        phoneNumberViewModel.onDoneButtonTapped = {
            [weak self] in
            self?.showSmsCodeScreen()

        }
        rootNavigationController?.viewControllers = [phoneNumberViewController]
    }

    private func showSmsCodeScreen() {
        let smsCodeViewModel = SmsCodeViewModel()
        let smsCodeViewController = SmsCodeViewController(viewModel: smsCodeViewModel)
        smsCodeViewModel.onDoneButtonTapped = {
            [weak self] in
            self?.showUserDetailsScreen()
        }
        rootNavigationController?.pushViewController(smsCodeViewController, animated: true)
    }

    private func showUserDetailsScreen() {
        let userDetailsViewModel = UserDetailsViewModel()
        let userDetailsViewController = UserDetailsViewController(viewModel: userDetailsViewModel)
        userDetailsViewModel.onFinishButtonTapped = {
            [weak self] in
            self?.onUserLoggedIn?()
        }
        rootNavigationController?.pushViewController(userDetailsViewController, animated: true)
    }
}