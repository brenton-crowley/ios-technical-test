//
//  URLSession+Extensions.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

extension UIImage {
    
    /// Helper function that loads a remote image. This method uses modern Swift concurrency
    /// - Parameter name: The url of the image to load
    /// - Returns: A UIImage base on the url.
    static func loadImageFromURL(_ url:URL) async -> UIImage? {
        
        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, _) = try await urlSession.data(for: urlRequest)
            
            return UIImage(data: data)
            
        } catch {
            print("Error downloading image: \(error.localizedDescription)")
        }
        
        
        return nil
    }
    
}
