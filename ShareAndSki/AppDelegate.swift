//
//  AppDelegate.swift
//  ShareAndSki
//
//  Created by karol.nadratowaski on 2019-03-26.
//  Copyright © 2019 Apolej Developer. All rights reserved.
//

import UIKit
import SwiftyBeaver

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var mainFlowController: FlowController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let console = ConsoleDestination()
        log.addDestination(console)
        let rootNavigationController = UINavigationController()
        window?.rootViewController = rootNavigationController
        mainFlowController = MainFlowController(rootNavigationController: rootNavigationController)
        mainFlowController.startFlow()
        window?.makeKeyAndVisible()
        return true
    }

}
