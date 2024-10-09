//  SignUpVC.swift
//  MyWater
//  Created by Ilya Zablotski

import Firebase
import SnapKit
import UIKit

final class SignUpVC: UIViewController {
    
    private let signUpView = SignUpView()
    private lazy var emailTextField = signUpView.entryFields.emailTextField
    private lazy var passwordTextField = signUpView.entryFields.passwordTextField
    private lazy var confirmPasswordField = signUpView.entryFields.confirmPasswordField
    private lazy var doneButton = signUpView.entryFields.doneButton
    private lazy var warningLabel = signUpView.entryFields.warningLabel
    private lazy var backButton = signUpView.backButton
    
    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupView()
        makeConstraints()
        bind()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordField.delegate = self
        
        // Ups and down view with keyboard (Method from UIVC extension)
        startObservingKeyboard()
        
        // Hiding the keyboard by tapping the screen
        setupGestureRecognizers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signUpView.background.startWaveAnimation()
    }
}

// MARK: - Private Methods

private extension SignUpVC {
    private func setupStyle() {
        view.backgroundColor = #colorLiteral(red: 0.06453060359, green: 0.3772945702, blue: 0.9141336083, alpha: 1)
        view.tintColor = .white
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        view.addSubview(signUpView)
    }
    
    // MARK: - Constraints
    
    private func makeConstraints() {
        signUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bindings
    
    private func bind() {
        backButton.addAction(UIAction(handler: { [weak self] _ in
            self?.backButton.animateClick {
                self?.dismiss(animated: true, completion: nil)
            }
        }), for: .touchUpInside)
        
        doneButton.addAction(UIAction(handler: { [weak self] _ in
            self?.doneButton.animateClick {
                self?.createUser()
            }
        }), for: .touchUpInside)
    }
    
    // Create and verifying user authorisation data
    private func createUser() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              password == confirmPasswordField.text
        else {
            showError(forLabel: warningLabel, withText: "Passwords do not match")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                if let err = error {
                    switch err.localizedDescription {
                    case "The email address is already in use by another account.":
                        self?.showError(forLabel: self?.warningLabel, withText: "This email is already in use")
                    default:
                        self?.showError(forLabel: self?.warningLabel, withText: err.localizedDescription)
                    }
                } else {
                    self?.presentVC(named: TabBarController())
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension SignUpVC: UITextFieldDelegate {
    // Actions after pressing return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
            createUser()
        }
        
        return true
    }
}
