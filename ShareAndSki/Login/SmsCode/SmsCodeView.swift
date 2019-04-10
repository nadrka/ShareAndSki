import UIKit
import SnapKit
import PinCodeTextField

class SmsCodeView: UIView {
    private var viewModel: SmsCodeViewModel
    private var descriptionSectionView: DescriptionWithImageView!
    private var pinCodeTextField: PinCodeTextField!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: SmsCodeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .white
        setupView()
        applyConstraints()
    }

    private func setupView() {
        let image = UIImage(named: "lock")
        descriptionSectionView = DescriptionWithImageView(image: image!, description: "We have sent you an SMS with a code to the number above. \n\nTo complete your phone number verification, please enter the 6-digit activation code")
        setupPinCodeTextField()
        addSubview(descriptionSectionView)
        addSubview(pinCodeTextField)
    }

    private func setupPinCodeTextField() {
        pinCodeTextField = PinCodeTextField()
        pinCodeTextField.delegate = self
        pinCodeTextField.characterLimit = 6
        pinCodeTextField.keyboardType = .decimalPad
        pinCodeTextField.textColor = .black
        pinCodeTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        pinCodeTextField.becomeFirstResponder()
    }

    private func applyConstraints() {
        descriptionSectionView.snp.makeConstraints{
            make in
            make.top.equalTo(self.snp.topMargin).inset(10.sketchHeight)
            make.width.equalToSuperview()
        }
        pinCodeTextField.snp.makeConstraints{
            make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionSectionView.snp.bottom).inset(-45.sketchHeight)
            make.height.equalTo(40)
            make.width.equalToSuperview().inset(5.sketchWidth)
        }
    }
}

extension SmsCodeView: PinCodeTextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: PinCodeTextField) {
        log.debug("End editing")
        viewModel.onDoneButtonTapped?()
    }
}

