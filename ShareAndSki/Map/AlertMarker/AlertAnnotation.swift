import Foundation
import MapKit

class AlertAnnotation: NSObject, MKAnnotation {
    var alert: Alert
    private(set) var coordinate: CLLocationCoordinate2D
    private(set) var title: String? = ""

    init(alert: Alert) {
        self.alert = alert
        self.coordinate = CLLocationCoordinate2D(latitude: alert.latitude, longitude: alert.longitude)
    }

}
