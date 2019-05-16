import Foundation
import ObjectMapper

class PhoneNumber: Mappable {
    private var phoneNumber: String = ""
    required init?(map: Map) {

    }

    init(number: String) {
        self.phoneNumber = number
    }

    func mapping(map: Map) {
        phoneNumber <- map["phoneNumber"]
    }
}