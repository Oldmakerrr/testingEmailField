//
//  StrinExtensions.swift
//  testingEmailField
//
//  Created by Apple on 08.04.2022.
//

import Foundation

extension String {
    
    //работа с предикатоми (Predicates)
    func isValid() -> Bool {
        let format = "SELF MATCHES %@"
        let regEx = "[a-zA-Z0-9._]+@[a-z,A-Z]+\\.[a-zA-Z]{2,}"
        return NSPredicate(format: format, regEx).evaluate(with: self)
    }
}
