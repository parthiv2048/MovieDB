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
        KeychainManager.shared.save(password, service: "com.moviedb.auth", account: username)
    }
}

