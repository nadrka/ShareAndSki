import UIKit

class MainFlowController: FlowController {

    private weak var rootNavigationController: UINavigationController?
    private var loginFlowController: FlowController!
    private var dashBoardFlowController: FlowController!

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }

    func startFlow() {
        // if logged in start login flow
        // else start main flow
    }
}