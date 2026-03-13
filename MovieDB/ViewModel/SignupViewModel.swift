//
//  SignupViewModel.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 3/12/26.
//

import Foundation
import Security

protocol SignupViewModelProtocol {
    func signup(username: String, password: String)
}

class SignupViewModel: SignupViewModelProtocol {
    init() {}
    
    func signup(username: String, password: String) {
        KeychainManager.shared.save(password, service: ServiceConstants.auth.rawValue, account: username)
    }
}

