import Foundation
import ObjectMapper

class User: Mappable{
    private(set) var id: Int = 0
    private(set) var nickname: String = ""
    private(set) var phoneNumber: String = ""
    private(set) var longitude: Double = 0.0
    private(set) var latitude: Double = 0.0
    private(set) var latitudeStr: String = ""
    private(set) var longitudeStr: String = ""
    var nameFromContactList: String = ""

    init(id: Int = 0, nickname: String, phoneNumber: String, longitude: Double = 0, latitude: Double = 0, nameFromContactList: String = "") {
        self.id = id
        self.nickname = nickname
        self.phoneNumber = phoneNumber
        self.longitude = longitude
        self.latitude = latitude
        self.nameFromContactList = nameFromContactList
    }

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["id"]
        nickname <- map["nickname"]
        phoneNumber <- map["phoneNumber"]
        longitudeStr <- map["longitude"]
        latitudeStr <- map["latitude"]
        nameFromContactList <- map["nameFromContactList"]
        latitude = Double(latitudeStr) ?? 0.0
        longitude = Double(longitudeStr) ?? 0.0
    }
}