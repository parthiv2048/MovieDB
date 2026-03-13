//
//  UserDefaultsManager.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 3/13/26.
//

import Foundation

class UserDefaultsManager {
    static let userDefaults: UserDefaults = .standard
    
    static func saveData(_ data: Data, forKey key: String) {
        userDefaults.set(data, forKey: key)
    }
    
    static func saveBool(_ bool: Bool, forKey key: String) {
        print("DEBUG SAVE: key=\(key), value=\(bool), suite=\(userDefaults.description)")
        userDefaults.set(bool, forKey: key)
        userDefaults.synchronize()
    }
    
    static func getData(forKey key: String) -> Data? {
        return userDefaults.data(forKey: key)
    }
    
    static func getBool(forKey key: String) -> Bool {
        let value = userDefaults.bool(forKey: key)
        print("DEBUG GET: key=\(key), value=\(value), suite=\(userDefaults.description)")
        return value
    }
    
    static func removeData(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
