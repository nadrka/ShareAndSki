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
        mainTabBarController.groupsViewModel.onCreateButtonTapped = {
            [weak self] in
            self?.showCreateGroupScreen()
        }
    }

    private func showCreateGroupScreen() {
        let createGroupViewModel = CreateGroupViewModel()
        let createGroupVC = CreateGroupViewController(viewModel: createGroupViewModel)
        mainTabBarController.groupNavigationController.pushViewController(createGroupVC, animated: true)
    }
}