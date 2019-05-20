import Foundation
import MapKit

class AlertAnnotationView: MKAnnotationView {

    var alert: Alert
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(annotation: MKAnnotation?, reuseIdentifier: String, alert: Alert) {
        self.alert = alert
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.isDraggable = false
        self.isEnabled = true
        self.isHighlighted = true
        createAnnotationView()
    }


    private func createAnnotationView() {
        canShowCallout = true
        image = UIImage(named: "alert")
    }
}
