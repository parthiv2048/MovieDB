//
//  LoginViewModel.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 3/12/26.
//

import Foundation
import Security

protocol LoginViewModelProtocol {
    func login(username: String, password: String, rememberUsername: Bool) -> Bool
    func getUsername() -> String?
    func getRememberUsername() -> Bool
}

class LoginViewModel: LoginViewModelProtocol {
    init() {}
    
    func login(username: String, password: String, rememberUsername: Bool) -> Bool {
        let retrievedPassword = KeychainManager.shared.read(service: ServiceConstants.auth.rawValue, account: username)
        let success = retrievedPassword == password
        if success {
            print("DEBUG: Saving rememberUsername = \(rememberUsername)")
            UserDefaultsManager.saveBool(rememberUsername, forKey: UserDefaultsKeys.rememberUsername.rawValue)
            if rememberUsername {
                guard let usernameData = username.data(using: .utf8) else { return false }
                UserDefaultsManager.saveData(usernameData, forKey: UserDefaultsKeys.username.rawValue)
            } else {
                UserDefaultsManager.removeData(forKey: UserDefaultsKeys.username.rawValue)
            }
        }
        return success
    }
    
    func getUsername() -> String? {
        let retrievedUsernameData = UserDefaultsManager.getData(forKey: UserDefaultsKeys.username.rawValue)
        if let uwData = retrievedUsernameData, let retrievedUsername = String(data: uwData, encoding: .utf8) {
            return retrievedUsername
        }
        return nil
    }
    
    func getRememberUsername() -> Bool {
        return UserDefaultsManager.getBool(forKey: UserDefaultsKeys.rememberUsername.rawValue)
    }
}
