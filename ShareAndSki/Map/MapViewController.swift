import UIKit
import FloatingPanel

class MapViewController: UIViewController {
    private var mainView: MapView!
    private var fpc: FloatingPanelController!
    let viewModel: MapViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(mapViewModel: MapViewModel) {
        self.viewModel = mapViewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupFloatingPanel()
    }

    private func setupView() {
        mainView = MapView(viewModel: viewModel)
        view.addSubview(mainView)
        mainView.fillParent()
    }

    private func setupFloatingPanel() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        let sharingFriendsViewModel = SharingFriendsViewModel()
        let sharingFriendsViewController = SharingFriendsViewController(viewModel: sharingFriendsViewModel)
        fpc.set(contentViewController: sharingFriendsViewController)
        fpc.addPanel(toParent: self)
        fpc.track(scrollView: sharingFriendsViewController.getTableView())
        fpc.show(animated: true)
    }

}

extension MapViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return SharingFriendsFloatingPanelLayout()
    }
}