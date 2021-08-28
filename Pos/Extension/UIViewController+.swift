//
//  UIViewController+.swift
//  Pos
//
//  Created by Nam Ngây on 28/08/2021.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {
    
    func hideNavBar() {
        let nav = self.navigationController?.navigationBar
        let transparentPixel = UIImage()
        nav?.setBackgroundImage(transparentPixel, for: UIBarMetrics.default)
        nav?.shadowImage = transparentPixel
        nav?.isTranslucent = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func topController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController {
        if let navigationController = controller as? UINavigationController {
            return topController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topController(controller: presented)
        }
        //back button no title
        if let controller = controller {
            DispatchQueue.main.async {
                let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                controller.navigationItem.backBarButtonItem = backBarButtonItem
            }
        }
        return controller ?? UIViewController()
    }
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
}
