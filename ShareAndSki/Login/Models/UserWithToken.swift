import Foundation
import ObjectMapper

struct UserWithToken: Mappable {
    private(set) var user: User!
    private(set) var token: String = ""

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        user <- map["user"]
        token <- map["token"]
    }
}