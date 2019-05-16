import Foundation
import ObjectMapper

class Position: Mappable {
    private(set) var longitude: Double = 0
    private(set) var latitude: Double = 0

    required init?(map: Map) {

    }

    init(longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }

    func mapping(map: Map) {
        longitude <- map["longitude"]
        latitude <- map["latitude"]
    }
}