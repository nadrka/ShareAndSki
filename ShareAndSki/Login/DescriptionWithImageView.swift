import UIKit
import SnapKit

class DescriptionWithImageView: UIView {
    private var descriptionImage: UIImageView = UIImageView()

    private var descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(image: UIImage, description: String) {
        descriptionImage.image = image
        self.descriptionLabel.text = description
        super.init(frame: .zero)
        setupView()
        applyConstraints()
    }


    private func setupView() {
        addSubview(descriptionImage)
        addSubview(descriptionLabel)
    }

    private func applyConstraints() {
        descriptionImage.snp.makeConstraints{
            make in
            make.top.equalToSuperview().inset(10.sketchHeight)
            make.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints{
            make in
            make.top.equalTo(descriptionImage.snp.bottom).inset(-15.sketchHeight)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}
