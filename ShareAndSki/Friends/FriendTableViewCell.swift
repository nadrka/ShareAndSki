import UIKit

class FriendTableViewCell: UITableViewCell {

    static let reuseId = "FriendTableViewCellReuseId"

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

}