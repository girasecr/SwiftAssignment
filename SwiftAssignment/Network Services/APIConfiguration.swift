//
//  APIConfiguration.swift
//  SwiftAssignment
//
//  Created by Chetan Girase on 13/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import UIKit

//This struct connect all the comon urls and api keys
struct Basic {
    static let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    static let apiKey = ""
    static var TIME_OUT = 60.0
    let headerUsername = ""
    let headerPassword = ""
}

public struct HEADERS {
    static let urlEncoded: [String: String] = ["Content-Type":"application/x-www-form-urlencoded; charset=UTF-8","Accept":"application/json; charset=UTF-8","cache-control": "no-cache"]
    static let appJson: [String: String] = ["Content-Type":"application/json; charset=UTF-8", "Accept":"application/json; charset=UTF-8","cache-control": "no-cache"]
    static let multipart: [String: String] = ["Content-type": "multipart/form-data"]
}

struct API_SUBDOMAIN {
    // place holder module name
    static let ENVIRONMENT = ""
}

struct API_ENDPOINT {
    // place holder method name
    static let PSI = ""
}

class APIConfiguration {
    var api_SubDomain: String
    var api_EndPoint: String
    var extraParameters: String
    var httpMethod: HTTPMethod
    var requestObject: Encodable?

    init(api_SubDomain: String = "", api_EndPoint: String = "", extraParameters: String = "", httpMethod: HTTPMethod = .get, requestObject: Encodable? = nil) {
        self.api_SubDomain = api_SubDomain
        self.api_EndPoint = api_EndPoint
        self.extraParameters = extraParameters
        self.httpMethod = httpMethod
        self.requestObject = requestObject
    }

    fileprivate func getUrl() -> URL? {

        let urlString = String(format: "%@%@%@%@", Basic.url, self.api_SubDomain, self.api_EndPoint, self.extraParameters)
        print("*** Request Url ***\n\(urlString)")
        return URL.init(string: urlString)
    }

    fileprivate func httpBody()-> Data? {
        var data: Data?
        if let jsonData = self.requestObject?.toJSONData() {
            let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            print("*** Request Json *** \n\(jsonString)")
            data = jsonString.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil).data(using: .utf8, allowLossyConversion: false)
        }
        return data
    }

    func configuration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Basic.TIME_OUT
        return configuration
    }

    func getURLRequest() -> URLRequest? {
        guard let url = getUrl() else { return nil }
        return URLRequest.init(url: url)
    }

    func postURLRequest() -> URLRequest? {
        guard let url = getUrl() else { return nil }
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = self.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = HEADERS.appJson
        urlRequest.httpBody = self.httpBody()
        return urlRequest
    }
}