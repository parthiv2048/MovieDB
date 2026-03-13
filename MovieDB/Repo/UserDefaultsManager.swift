//
//  UserDefaultsManager.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 3/13/26.
//

import Foundation

class UserDefaultsManager {
    /// Standard UserDefaults
    static let userDefaults: UserDefaults = .standard
    
    // MARK: - Static Save, Read, and Delete Methods for Data
    
    static func saveData(_ data: Data, forKey key: String) {
        userDefaults.set(data, forKey: key)
    }
    
    static func getData(forKey key: String) -> Data? {
        return userDefaults.data(forKey: key)
    }
    
    static func removeData(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    // MARK: - Static Save and Read Methods for Bool
    
    static func getBool(forKey key: String) -> Bool {
        let value = userDefaults.bool(forKey: key)
        print("DEBUG GET: key=\(key), value=\(value), suite=\(userDefaults.description)")
        return value
    }
    
    static func saveBool(_ bool: Bool, forKey key: String) {
        print("DEBUG SAVE: key=\(key), value=\(bool), suite=\(userDefaults.description)")
        userDefaults.set(bool, forKey: key)
    }
}
