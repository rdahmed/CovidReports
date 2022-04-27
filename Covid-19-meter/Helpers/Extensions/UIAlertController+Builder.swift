//
//  UIAlertController+Builder.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 27/04/2022.
//
// Source: https://gist.github.com/amfathi/8fe64502a578fdc84a5bfe332ce1d58a

import UIKit

extension UIAlertController {
    
    // MARK: - Alert Types
    
    static func alert(title: String = "", message: String = "") -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert).tint()
    }
    
    static func info(title: String = "", message: String = "") -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert).tint().addOk()
    }
    
    static func sheet(title: String? = nil, message: String? = nil) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }
    
    static func error(message: String = "") -> UIAlertController {
        return UIAlertController(title: "", message: message, preferredStyle: .alert).tint().addOk()
    }
    
    // MARK: - Tint
    
    func tint(_ color: UIColor = .blue) -> UIAlertController {
        view.tintColor = color
        return self
    }
    
    // MARK: - Basic Actions
    
    @discardableResult
    func addDefault(title: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: title, style: .default, handler: handler))
        return self
    }
    
    @discardableResult
    func addDestructive(title: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: title, style: .destructive, handler: handler))
        return self
    }
    
    @discardableResult
    func addCancel(title: String? = "Cancel", handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: title, style: .cancel, handler: handler))
        return self
    }
    
    // MARK: - Other Actions
    
    @discardableResult
    func addOk(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addDefault(title: "Ok", handler: handler)
    }
    
    // MARK: - Presentation
    // WARNING: This will crash on iPad if the alert type is sheet, still needs handling here
    func present(on presentingViewController: UIViewController) {
        presentingViewController.present(self, animated: true, completion: nil)
    }
    
}
