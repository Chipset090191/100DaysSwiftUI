//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Михаил Тихомиров on 21.04.2023.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file:String) -> T {
        
        // first we locate our file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        // then we load our file
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        
        // and then we decode our file
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
        
        
        
    }
}
