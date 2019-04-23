import UIKit

class SharingFriendsViewController: UIViewController {
    private var mainView: SharingFriendsView!
    private var viewModel: SharingFriendsViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: SharingFriendsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
    }

    private func setupView() {
        mainView = SharingFriendsView(viewModel: viewModel)
        view.addSubview(mainView)
        mainView.fillParent()
    }

    func getTableView() -> UITableView {
        return mainView.tableView
    }
}