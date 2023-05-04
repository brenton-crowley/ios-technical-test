//
//  URLSession+Extensions.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

extension UIImage {
    
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
