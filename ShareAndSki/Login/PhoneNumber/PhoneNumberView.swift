import UIKit
import SnapKit
import FlagPhoneNumber

class PhoneNumberView: UIView {
    private var viewModel: PhoneNumberViewModel
    private var descriptionSectionView: DescriptionWithImageView!
    private var doneButton: RoundedButton!
    var phoneNumberTextField: FPNTextField!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: PhoneNumberViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupLayout()
        setupView()
        applyConstraints()
    }

    private func setupLayout() {
        backgroundColor = .white
    }

    private func setupView() {
        let image = UIImage(named: "phone")
        descriptionSectionView = DescriptionWithImageView(image: image!, description: "Please confirm your country code and enter your phone number")
        doneButton = RoundedButton(buttonTitle: "DONE".localized, color: Colors.mainBlue)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        addGestureRecognizerToView()
        setupPhoneNumberView()
        addSubview(descriptionSectionView)
        addSubview(doneButton)
        addSubview(phoneNumberTextField)
    }

    @objc func doneButtonTapped() {
        viewModel.onDoneButtonTapped?()
    }

    private func addGestureRecognizerToView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onViewTapped))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func onViewTapped() {
        endEditing(true)
    }

    private func setupPhoneNumberView() {
        phoneNumberTextField = FPNTextField()
        phoneNumberTextField.clearButtonMode = .whileEditing
        phoneNumberTextField.borderStyle = .roundedRect;
        phoneNumberTextField.autocapitalizationType = .none;
        phoneNumberTextField.autocorrectionType = .no
        phoneNumberTextField.delegate = self
        phoneNumberTextField.placeholder = "PHONE_NUMBER".localized
        phoneNumberTextField.keyboardType = .decimalPad
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    private func applyConstraints() {
        descriptionSectionView.snp.makeConstraints{
            make in
            make.top.equalTo(self.snp.topMargin).inset(10.sketchHeight)
            make.width.equalToSuperview()
        }
        doneButton.snp.makeConstraints{
            make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60.sketchHeight)
            make.width.equalToSuperview().inset(25.sketchWidth)
            make.bottom.equalTo(self.snp.bottomMargin).inset(15.sketchHeight)
        }

        phoneNumberTextField.snp.makeConstraints{
            make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionSectionView.snp.bottom).inset(-35.sketchHeight)
            make.height.equalTo(40)
            make.width.equalToSuperview().inset(15.sketchWidth)
        }
    }
}

extension PhoneNumberView: UITextFieldDelegate, FPNTextFieldDelegate {

    @objc func textFieldDidChange(_ textField: UITextField) {
    }

    public func fpnDidSelectCountry(name: String, dialCode: String, code: String) {

    }

    public func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    }
}

