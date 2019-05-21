import UIKit

class GroupTableViewController: UITableViewController {

    let viewModel: GroupViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: GroupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()
        setupTableView()
        bindViewModel()
    }

    private func setupTableView() {
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }

    private func bindViewModel() {
        viewModel.onListUpdated = {
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchGroups()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.reuseId, for: indexPath) as! FriendTableViewCell
        let group = viewModel.groups[indexPath.row]
        let cellViewModel = GroupCellViewModel(cellUsage: .friendsToShareLocation, group: group)
        cell.setup(cellViewModel)
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let createGroupView = CreateGroupButtonView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCreateButtonTapped))
        createGroupView.addGestureRecognizer(tapGestureRecognizer)
        return createGroupView
    }

    @objc func onCreateButtonTapped() {
        viewModel.onCreateButtonTapped?()
        log.debug("Create group button tapped!")
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65.sketchHeight
    }


}
