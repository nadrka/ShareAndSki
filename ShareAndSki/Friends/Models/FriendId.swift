import Foundation
import ObjectMapper

class FriendId: Mappable {
    private(set) var id: Int = 0

    required init?(map: Map) {

    }

    init(id: Int) {
        self.id = id
    }

    func mapping(map: Map) {
        id <- map["id"]
        id <- map["id"]
    }
}
