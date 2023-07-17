//
//  Codable+Extension.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

extension Encodable {
    /// Get dictionary from encodable
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
