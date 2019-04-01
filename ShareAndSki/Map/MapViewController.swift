import UIKit
import FloatingPanel

class MapViewController: UIViewController {
    private var mainView: MapView!
    private var fpc: FloatingPanelController!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupFloatingPanel()
    }

    private func setupView() {
        mainView = MapView()
        view.addSubview(mainView)
        mainView.fillParent()
    }

    private func setupFloatingPanel() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        let contentVC = UIViewController()
        contentVC.view.backgroundColor = .lightGray
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        fpc.show(animated: true)
    }

}

extension MapViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return SharingFriendsFloatingPanelLayout()
    }
}