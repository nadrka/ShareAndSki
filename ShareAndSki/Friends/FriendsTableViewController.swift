import UIKit
import JGProgressHUD

class FriendsTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var viewModel: FriendsViewModel
    let hud = JGProgressHUD(style: .dark)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    override func loadView() {
        super.loadView()
        setupTableView()
        setupSearchBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.checkForUserFromContacts()
    }

    private func bindViewModel() {
        viewModel.onListUpdated = {
            [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.onLoading = {
            isLoading in
            if isLoading {
                self.showLoader()
            } else {
                self.hideLoader()
            }
        }


    }

    private func showLoader() {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
    }

    private func hideLoader() {
        hud.dismiss(animated: true)
    }

    private func setupTableView() {
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
//        tableView.separatorStyle = .none
    }

    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.friendsFromApp.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.reuseId, for: indexPath) as! FriendTableViewCell
        let friend = viewModel.friendsFromApp[indexPath.row]
        let cellViewModel = DefaultFriendCellViewModel(cellUsage: .friendsToShareLocation, friend: friend)
        cell.setup(cellViewModel)
        return cell
    }
}
