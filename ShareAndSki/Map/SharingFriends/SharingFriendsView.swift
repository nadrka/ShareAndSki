import UIKit
import SnapKit

class SharingFriendsView: UIView {
    private var viewModel: SharingFriendsViewModel
    private(set) var tableView: UITableView!

    private var friendThatShareLocationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Friends that actively share location"
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = Colors.lightGray
        label.textAlignment = .center
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: SharingFriendsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        applyConstraints()
    }


    private func setupView() {
        backgroundColor = .white
        addSubview(friendThatShareLocationLabel)
        setupTableView()
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.reuseId)
        tableView.tableFooterView = UIView()
        addSubview(tableView)
    }

    private func applyConstraints() {
        friendThatShareLocationLabel.snp.makeConstraints {
            make in
            make.top.equalToSuperview().inset(20.sketchHeight)
            make.width.equalToSuperview()
            make.height.equalTo(50.sketchHeight)
        }
        tableView.snp.makeConstraints{
            make in
            make.width.equalToSuperview()
            make.top.equalTo(friendThatShareLocationLabel.snp.bottom).inset(-5.sketchHeight)
            make.bottom.equalToSuperview()
        }
    }
}

extension SharingFriendsView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfFriendsThatShareLocation()
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.reuseId, for: indexPath) as! FriendTableViewCell
        let friend = viewModel.getFriendThatSharesLocation(with: indexPath.row)
        let cellViewModel = DefaultFriendCellViewModel(cellUsage: .friendsSharingLocation, friend: friend)
        cell.setup(cellViewModel)
        return cell
    }
}