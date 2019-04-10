import UIKit

class PhoneNumberViewController: UIViewController {
    private var mainView: PhoneNumberView!
    private var viewModel: PhoneNumberViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: PhoneNumberViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        title = "YOUR_PHONE_NUMBER".localized
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "DONE".localized, style: .done, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem?.tintColor = .lightGray
    }

    @objc func doneTapped() {
        viewModel.onDoneButtonTapped?()
    }

    private func setupView() {
        mainView = PhoneNumberView(viewModel: viewModel)
        view.addSubview(mainView)
        mainView.fillParent()
    }



}

