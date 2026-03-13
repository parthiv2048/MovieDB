//
//  LoginVC.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 3/12/26.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var loginHeader = {
        let header = UILabel()
        header.text = "Login"
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
        passwordTF.autocapitalizationType = .none
        passwordTF.placeholder = "Password"
        passwordTF.borderStyle = .roundedRect
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordTF
    }()
    
    private lazy var rememberUsernameToggle = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    private lazy var rememberUsernameLabel = {
        let label = UILabel()
        label.text = "Remember Username:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorConstants.cellBackgroundColor.getColor
        button.layer.cornerRadius = 8
        
        button.addAction(UIAction {_ in
            let username = self.usernameTF.text ?? ""
            let password = self.passwordTF.text ?? ""
            let userVerified = self.loginViewModel.login(
                username: username,
                password: password,
                rememberUsername: self.rememberUsernameToggle.isOn
            )
            if userVerified {
                self.navigateToMovieListView()
            } else {
                self.showAlert(title: "Error", message: "User credentials couldn't be found")
            }
        }, for: .touchUpInside)
        
        return button
    }()
    
    private lazy var signupButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorConstants.movieListBackgroundColor.getColor
        button.layer.cornerRadius = 8
        
        button.addAction(UIAction {_ in
            self.navigateToSignup()
        }, for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties (View Model)
    
    private var loginViewModel: LoginViewModelProtocol
    
    // MARK: - Initializer (Injection)
    
    init(loginViewModel: LoginViewModelProtocol) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorConstants.viewBackgroundColor.getColor
        
        let shouldRemember = loginViewModel.getRememberUsername()
        rememberUsernameToggle.isOn = shouldRemember
        if shouldRemember {
            usernameTF.text = loginViewModel.getUsername()
        }
        
        view.addSubview(loginHeader)
        view.addSubview(usernameTF)
        view.addSubview(passwordTF)
        view.addSubview(rememberUsernameToggle)
        view.addSubview(rememberUsernameLabel)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        
        addConstraints()
    }
    
    // MARK: - Add Constraints
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            loginHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            loginHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameTF.topAnchor.constraint(equalTo: loginHeader.bottomAnchor, constant: 100),
            usernameTF.centerXAnchor.constraint(equalTo: loginHeader.centerXAnchor),
            usernameTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            passwordTF.topAnchor.constraint(equalTo: usernameTF.bottomAnchor, constant: 20),
            passwordTF.centerXAnchor.constraint(equalTo: loginHeader.centerXAnchor),
            passwordTF.widthAnchor.constraint(equalTo: usernameTF.widthAnchor),
            
            rememberUsernameToggle.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 10),
            rememberUsernameToggle.trailingAnchor.constraint(equalTo: passwordTF.trailingAnchor),
            
            rememberUsernameLabel.centerYAnchor.constraint(equalTo: rememberUsernameToggle.centerYAnchor),
            rememberUsernameLabel.trailingAnchor.constraint(equalTo: rememberUsernameToggle.leadingAnchor, constant: -10),
            
            loginButton.topAnchor.constraint(equalTo: rememberUsernameToggle.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: loginHeader.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: usernameTF.widthAnchor),
            
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40),
            signupButton.centerXAnchor.constraint(equalTo: loginHeader.centerXAnchor),
            signupButton.widthAnchor.constraint(equalTo: usernameTF.widthAnchor),
        ])
    }
}
