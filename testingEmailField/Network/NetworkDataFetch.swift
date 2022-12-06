//
//  NetworkDataFetch.swift
//  testingEmailField
//
//  Created by Apple on 08.04.2022.
//

import Foundation


class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchMail(verifiableMail: String, responce: @escaping (MailResponceModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData(verifiableMail: verifiableMail) { result in
            switch result {
            case .success(let data):
                do {
                    let mail = try JSONDecoder().decode(MailResponceModel.self, from: data)
                    responce(mail, nil)
                } catch let jsonError {
                    print(data)
                    print("Faild to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error receive requestin data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
