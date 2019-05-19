import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
                .joined()
    }
}

