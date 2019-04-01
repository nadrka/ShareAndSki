import UIKit

class GroupTableViewCell: UITableViewCell {

    static let reuseId = "GroupTableViewCellReuseId"

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

}