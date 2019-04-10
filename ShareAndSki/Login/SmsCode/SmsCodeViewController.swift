import UIKit

class SmsCodeViewController: UIViewController {
    private var mainView: SmsCodeView!
    private var viewModel: SmsCodeViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: SmsCodeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
    }

    private func setupView() {
        mainView = SmsCodeView(viewModel: viewModel)
        view.addSubview(mainView)
        mainView.fillParent()
    }


}

