//
//  SignupVC.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 3/12/26.
//

import UIKit

class SignupVC: UIViewController {
    
    private lazy var signupHeader = {
        let header = UILabel()
        header.text = "Sign Up"
        header.textColor = .white
        header.textAlignment = .center
        header.font = UIFont.boldSystemFont(ofSize: 30)
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var usernameTF = {
        let usernameTF = UITextField()
        usernameTF.placeholder = "Username"
        usernameTF.autocapitalizationType = .none
        usernameTF.borderStyle = .roundedRect
        usernameTF.translatesAutoresizingMaskIntoConstraints = false
        return usernameTF
    }()
    
    private lazy var passwordTF = {
        let passwordTF = UITextField()
        passwordTF.isSecureTextEntry = true
        passwordTF.placeholder = "Password"
        passwordTF.autocapitalizationType = .none
        passwordTF.borderStyle = .roundedRect
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        return passwordTF
    }()
    
    private lazy var signupButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorConstants.cellBackgroundColor.getColor
        button.layer.cornerRadius = 8
        
        button.addAction(UIAction {_ in
            let username = self.usernameTF.text ?? ""
            let password = self.passwordTF.text ?? ""
            self.signupViewModel.signup(username: username, password: password)
            self.navigateToMovieListView()
        }, for: .touchUpInside)
        
        return button
    }()
    
    private var signupViewModel: SignupViewModelProtocol
    
    init(signupViewModel: SignupViewModelProtocol) {
        self.signupViewModel = signupViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorConstants.viewBackgroundColor.getColor
        
        view.addSubview(signupHeader)
        view.addSubview(usernameTF)
        view.addSubview(passwordTF)
        view.addSubview(signupButton)
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            signupHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            signupHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameTF.topAnchor.constraint(equalTo: signupHeader.bottomAnchor, constant: 100),
            usernameTF.centerXAnchor.constraint(equalTo: signupHeader.centerXAnchor),
            usernameTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            passwordTF.topAnchor.constraint(equalTo: usernameTF.bottomAnchor, constant: 20),
            passwordTF.centerXAnchor.constraint(equalTo: signupHeader.centerXAnchor),
            passwordTF.widthAnchor.constraint(equalTo: usernameTF.widthAnchor),
            
            signupButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 40),
            signupButton.centerXAnchor.constraint(equalTo: signupHeader.centerXAnchor),
            signupButton.widthAnchor.constraint(equalTo: usernameTF.widthAnchor),
        ])
    }
}
