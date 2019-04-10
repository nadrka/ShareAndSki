import UIKit

class UserDetailsViewController: UIViewController {
    private var mainView: UserDetailsView!
    private var viewModel: UserDetailsViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        title = "EDIT_PROFILE".localized
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "FINISH".localized, style: .done, target: self, action: #selector(finishTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.hidesBackButton = true
    }

    @objc func finishTapped() {
        viewModel.onFinishButtonTapped?()
    }

    private func setupView() {
        mainView = UserDetailsView(viewModel: viewModel)
        view.addSubview(mainView)
        mainView.fillParent()
    }


}

