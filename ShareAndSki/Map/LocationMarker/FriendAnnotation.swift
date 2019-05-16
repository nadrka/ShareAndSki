import Foundation
import MapKit

class FriendAnnotation: NSObject, MKAnnotation {
    var user: User
    private(set) var coordinate: CLLocationCoordinate2D
    private(set) var title: String? = ""

    init(user: User) {
        self.user = user
        self.title = user.nickname
        self.coordinate = CLLocationCoordinate2D(latitude: user.latitude, longitude: user.longitude)
    }

}
