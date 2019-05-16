import UIKit
import SnapKit

class UserDetailsView: UIView {
    private var viewModel: UserDetailsViewModel
    private var descriptionSectionView: DescriptionWithImageView!
    private var finishButton: RoundedButton!
    private var nameTextField: UITextField!
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .white
        setupView()
        applyConstraints()
    }

    private func setupView() {
        let image = UIImage(named: "name")
        descriptionSectionView = DescriptionWithImageView(image: image!, description: "Enter your name. It will be displayed to your friends in a notification")
        setupNameTextField()
        finishButton = RoundedButton(buttonTitle: "FINISH".localized, color: Colors.mainBlue)
        finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        addGestureRecognizerToView()
        addSubview(descriptionSectionView)
        addSubview(nameTextField)
        addSubview(finishButton)
    }

    private func setupNameTextField() {
        nameTextField = UITextField()
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.borderStyle = .roundedRect;
        nameTextField.autocapitalizationType = .none;
        nameTextField.autocorrectionType = .no
        nameTextField.delegate = self
        nameTextField.placeholder = "NAME_MAX_25_CHAR".localized
        nameTextField.keyboardType = .alphabet
    }

    @objc func finishButtonTapped() {
        let userName = nameTextField.text ?? ""
        viewModel.validate(userName: userName)
    }

    private func addGestureRecognizerToView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onViewTapped))
        addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func onViewTapped() {
        endEditing(true)
    }

    private func applyConstraints() {
        descriptionSectionView.snp.makeConstraints{
            make in
            make.top.equalTo(self.snp.topMargin).inset(10.sketchHeight)
            make.width.equalToSuperview()
        }

        nameTextField.snp.makeConstraints{
            make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionSectionView.snp.bottom).inset(-35.sketchHeight)
            make.height.equalTo(40)
            make.width.equalToSuperview().inset(15.sketchWidth)
        }

        finishButton.snp.makeConstraints{
            make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60.sketchHeight)
            make.width.equalToSuperview().inset(25.sketchWidth)
            make.bottom.equalTo(self.snp.bottomMargin).inset(15.sketchHeight)
        }
    }
}


extension UserDetailsView: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 25
    }
}
