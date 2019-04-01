import Foundation
import FloatingPanel

class SharingFriendsFloatingPanelLayout: FloatingPanelLayout {

    public var initialPosition: FloatingPanelPosition {
        return .tip
    }

    public var supportedPositions: Set<FloatingPanelPosition> {
        return [.full, .tip]
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 16.0 // A top inset from safe area
        case .half: return 216.0 // A bottom inset from the safe area
        case .tip: return 44.0 // A bottom inset from the safe area
        default: return nil // Or `case .hidden: return nil`
        }
    }
}