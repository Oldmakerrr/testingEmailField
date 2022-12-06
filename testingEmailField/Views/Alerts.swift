//
//  Alerts.swift
//  testingEmailField
//
//  Created by Apple on 08.04.2022.
//

import Foundation
import UIKit

class Alerts {
    
    private static func showSimpleAlert(vc: UIViewController, title: String, message: String) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    private static func showChangeAlert(vc: UIViewController,
                                       title: String,
                                       message: String,
                                       completion: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) {_ in
            completion()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancel)
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showResultAlert(vc: UIViewController, message: String) {
        showSimpleAlert(vc: vc, title: "Result", message: message)
    }
    
    static func showErrorAlert(vc: UIViewController, message: String, completion: @escaping() -> Void) {
        showChangeAlert(vc: vc, title: "Error", message: message, completion: completion)
    }
}
