import UIKit

class MainFlowController: FlowController {
    private weak var rootNavigationController: UINavigationController!
    private var onBoardingFlow: OnboardingFlowController!
    private var mapFlow: FlowController!

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }

    func startFlow() {
        startOnboardingFlow()
    }

    private func startOnboardingFlow() {
        onBoardingFlow = OnboardingFlowController(rootNavigationController: rootNavigationController)
        onBoardingFlow.onUserAlreadyLoggedIn = {
            [weak self] in
            self?.showMapScreen()
        }
        onBoardingFlow.onUserLoggedIn = {
            [weak self] in
            self?.showMapScreen()
        }
        onBoardingFlow.startFlow()
    }

    private func showMapScreen() {
        let mainTabBarController = MainTabBarController()
        rootNavigationController.setNavigationBarHidden(true, animated: true)
        rootNavigationController.pushViewController(mainTabBarController, animated: true)
    }
}