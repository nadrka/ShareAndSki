import Foundation
import ObjectMapper

class Token: Mappable {
    private var token: String = ""
    required init?(map: Map) {

    }

    init(token: String) {
        self.token = token
    }

    func mapping(map: Map) {
        token <- map["token"]
    }
}