//
//  RequestManager.swift
//  SwiftAssignment
//
//  Created by Chetan Girase on 13/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import UIKit

class RequestManager {
    class var sharedInstance: RequestManager {
        struct Singleton {
            static let instance = RequestManager()
        }
        return Singleton.instance
    }

    func withGet(apiConfiguration: APIConfiguration, completionHandler: @escaping JSONCompletionHandler) {
        let configuration = apiConfiguration.configuration()
        let session = URLSession(configuration: configuration)
        if let urlRequest = apiConfiguration.getURLRequest() {
            session.dataTask(with: urlRequest) { (data, _, error) in
                if let data = data {
                    if let json = String(data: data, encoding: String.Encoding.isoLatin1) {
                        completionHandler(json, nil)
                    } else {
                        completionHandler(nil, error)
                    }
                } else {
                    completionHandler(nil, error)
                }
            }.resume()
        }
    }
}
