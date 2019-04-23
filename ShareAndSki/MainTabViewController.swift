import UIKit


class MainTabBarController: UITabBarController {

    private(set) var mapViewModel: MapViewModel!
    private(set) var friendsViewModel: FriendsViewModel!
    private(set) var groupsViewModel: GroupViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        tabBar.tintColor = Colors.mainBlue
    }

    private func setupViewController() {
        let mapViewController = setupMapViewController()
        let friendsViewController = setupFriendsViewController()
        let groupsViewController = setupGroupsViewController()
        viewControllers = [
            createNavigationController(title: "MAP".localized, rootViewController: mapViewController, image: UIImage(named: "downloads")),
            createNavigationController(title: "FRIENDS".localized, rootViewController: friendsViewController, image: UIImage(named: "downloads")),
            createNavigationController(title: "GROUPS".localized, rootViewController: groupsViewController, image: UIImage(named: "search")),
        ]
    }

    private func setupMapViewController() -> MapViewController {
        mapViewModel = MapViewModel()
        let mapViewController = MapViewController(mapViewModel: mapViewModel)
        return mapViewController
    }

    private func setupFriendsViewController() -> FriendsTableViewController {
        friendsViewModel = FriendsViewModel()
        let friendsTableViewController = FriendsTableViewController(viewModel: friendsViewModel)
        return friendsTableViewController
    }

    private func setupGroupsViewController() -> GroupTableViewController {
        groupsViewModel = GroupViewModel()
        let groupsTableViewController = GroupTableViewController(viewModel: groupsViewModel)
        return groupsTableViewController
    }

    private func createNavigationController(title: String, rootViewController: UIViewController, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
}