import Foundation
import ObjectMapper

class Group: Mappable {
    private(set) var id: Int = 0
    private(set) var name = ""
    private(set) var adminId: Int = 0
    private(set) var friends: [Friend] = []


    init(id: Int = 0, name: String, adminId: Int = 0) {
        self.id = id
        self.name = name
        self.adminId = adminId
    }

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        adminId <- map["adminId"]
    }
}