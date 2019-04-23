import UIKit


class MapFlowController: FlowController {
    private weak var rootNavigationController: UINavigationController?
    private var mainTabBarController: MainTabBarController!

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }

    func startFlow() {
        showMapScreen()
    }

    private func showMapScreen() {
        mainTabBarController = MainTabBarController()
        bindControllers()
        rootNavigationController?.setNavigationBarHidden(true, animated: true)
        rootNavigationController?.pushViewController(mainTabBarController, animated: true)
    }

    private func bindControllers() {
        bindMapController()
        bindFriendController()
        bindGroupController()
    }

    private func bindMapController() {

    }

    private func bindFriendController() {

    }

    private func bindGroupController() {

    }
}