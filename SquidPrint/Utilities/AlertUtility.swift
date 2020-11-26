//
//  AlertUtility.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import Foundation
import UIKit

class AlertUtility {
    static func display(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.userDescription, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        
        displayAlert(alert)
    }
    
    private static func displayAlert(_ alert: UIAlertController) {
        UIApplication.topMostViewController?.present(alert, animated: true, completion: nil)
    }
}


private var associationKey: UInt8 = 0

extension UIAlertController {

    private var alertWindow: UIWindow! {
        get {
            return objc_getAssociatedObject(self, &associationKey) as? UIWindow
        }

        set(newValue) {
            objc_setAssociatedObject(self, &associationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func show() {
        self.alertWindow = UIWindow.init(frame: UIScreen.main.bounds)
        self.alertWindow.backgroundColor = .red

        let viewController = UIViewController()
        viewController.view.backgroundColor = .green
        self.alertWindow.rootViewController = viewController

        let topWindow = UIApplication.shared.windows.last
        if let topWindow = topWindow {
            self.alertWindow.windowLevel = topWindow.windowLevel + 1
        }

        self.alertWindow.makeKeyAndVisible()
        self.alertWindow.rootViewController?.present(self, animated: true, completion: nil)
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.alertWindow.isHidden = true
        self.alertWindow = nil
    }
}

extension UIApplication {
    /// The top most view controller
    static var topMostViewController: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController?.visibleViewController
    }
}

extension UIViewController {
    /// The visible view controller from a given view controller
    var visibleViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.visibleViewController
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.visibleViewController
        } else if let presentedViewController = presentedViewController {
            return presentedViewController.visibleViewController
        } else {
            return self
        }
    }
}
