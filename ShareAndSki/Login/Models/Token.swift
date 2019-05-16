import Foundation
import ObjectMapper

class Token: Mappable {
    private(set) var token: String = ""

    required init?(map: Map) {

    }

    init(token: String) {
        self.token = token
    }

    func mapping(map: Map) {
        token <- map["token"]
    }
}