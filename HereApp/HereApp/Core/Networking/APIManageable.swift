//
//  APIManageable.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

/// Patches a viewModel to give it functionality to perform URLRequests based on Requestable requests.
/// Also enables the parsing of returned JSON data into defined Decodable models.
protocol APIManageable {
    
    func performRequest(_ request: Requestable, expectedResponseCode: Int, printResponse: Bool) async throws -> Data?
    func parseJSONData<T: Decodable>(_ data: Data, type: T.Type) throws -> T?
}

extension APIManageable {
    
    func performRequest(_ request: Requestable, expectedResponseCode: Int = 200, printResponse: Bool  = false) async throws -> Data? {
        
        let urlSession = URLSession.shared
        let urlRequest = try request.makeURLRequest()
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        // Check that the status code is the expected response.
        let code = (response as? HTTPURLResponse)?.statusCode
        guard code == expectedResponseCode else { throw APIError.invalidResponseCode(expected: expectedResponseCode, received: code ?? -1) }
        
        return data
    }
    
    func parseJSONData<T: Decodable>(_ data: Data, type: T.Type) throws -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    }
    
}
