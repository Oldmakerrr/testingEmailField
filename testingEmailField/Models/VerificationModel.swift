//
//  VerificationModel.swift
//  testingEmailField
//
//  Created by Apple on 08.04.2022.
//

import Foundation


class VerificationModel {
    
    private let mailsArray = ["@gmail.com", "@yandex.ru", "@yahoo.com", "@mail.ru"]
    
    public var nameMail = String()
    public var filtredMailArray = [String]()
    
    private func filtringMails(text: String) {
        
        var domainMails = String()
        filtredMailArray = []
        
        guard let firstIndex = text.firstIndex(of: "@") else { return }
        let endIndex = text.index(before: text.endIndex)
        let range = text[firstIndex...endIndex]
        domainMails = String(range)
        
        mailsArray.forEach { mail in
            if mail.contains(domainMails) {
                if !filtredMailArray.contains(mail) {
                    filtredMailArray.append(mail)
                }
            }
        }
    }
    
    public func getFiltredMails(text: String) {
        filtringMails(text: text)
    }
    
    private func deriveNameMail(text: String) {
        guard let atSymbolIndex = text.firstIndex(of: "@") else { return }
        let endIndex = text.index(before: atSymbolIndex)
        let firstIndex = text.startIndex
        let range = text[firstIndex...endIndex]
        nameMail = String(range)
    }
    
    public func getMailName(text: String) {
        deriveNameMail(text: text)
    }
}
