//
//  Requestable.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

enum RequestMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

struct APIConstants {
    
    // URL Construction
    // https://transit.hereapi.com/v8
    static let scheme: String = "https"
    static let host: String = "transit.hereapi.com"
    static let version: String = "/v8"
    
    // ApiKey
    static let apiKeyPlistFilename: String = "apiKey"
    static var apiKey = ""
}

enum APIError: Error {
    
    case invalidURL, invalidResponseCode(expected: Int, received: Int), invalidData
    
}

protocol Requestable {
    
    // URLComponents
    var scheme: String { get }
    var host: String { get }
    var version: String { get }
    var path: String { get }
    
    // Headers
    var headers: [String: String] { get }
    
    // Query Paramerters
    var queryParams: [String: String?] { get }
    
    // Body Parameters
    var bodyParams: [String: Any] { get }
    
    // HTTP Method
    var requestMethod: RequestMethod { get }
}

// default implementation
extension Requestable {
    
    // url
    var scheme: String { APIConstants.scheme }
    var host: String { APIConstants.host }
    var version: String { APIConstants.version }
    var requestMethod: RequestMethod { .GET }
    
    // parameters
    var headers: [String: String] { [:] }
    var queryParams: [String: String?] { [:] }
    var bodyParams: [String: Any] { [:] }
    
    // authorization
    var addApiKey: Bool { true }
    var token: String { APIConstants.apiKey }
    
    func makeURLRequest() throws -> URLRequest {
        
        guard let url = makeURLComponents().url else { throw APIError.invalidURL}
        
        var urlRequest = URLRequest(url: url)
        
        // set the HTTP Methods
        urlRequest.httpMethod = requestMethod.rawValue
        
        // add the headers
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        return urlRequest
    }
    
    private func makeURLComponents() -> URLComponents {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = version + path // we'll set the path in a URL Request.
        
        // add any query parameters.
        if !queryParams.isEmpty {
            components.queryItems = queryParams.map { URLQueryItem(name: $0, value: $1)}
        }
        
        // add the auth token
        if addApiKey {
            components.queryItems?.append(URLQueryItem(name: "apiKey", value: APIConstants.apiKey))
        }
        
        return components
    }
    
    
}
