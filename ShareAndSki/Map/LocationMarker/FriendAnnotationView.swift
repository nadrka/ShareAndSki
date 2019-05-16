import Foundation
import MapKit

class FriendAnnotationView: MKAnnotationView {

    var user: User
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(annotation: MKAnnotation?, reuseIdentifier: String, user: User) {
        self.user = user
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.isDraggable = false
        self.isEnabled = true
        self.isHighlighted = true
    }


}
