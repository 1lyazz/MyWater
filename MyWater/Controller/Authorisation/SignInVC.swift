//  ViewController.swift
//  MyWater
//  Created by Ilya Zablotski

import Firebase
import SnapKit
import UIKit

final class SignInVC: UIViewController {
    
    private let signInView = SignInView()
    private lazy var warningLabel = signInView.entryFields.warningLabel
    private lazy var signInButton = signInView.entryFields.signInButton
    private lazy var signUpButton = signInView.signUpButton
    private lazy var forgotPassButton = signInView.forgotPassButton
    
    private lazy var emailTextField: WaterTextField = {
        let textField = signInView.entryFields.emailTextField
        textField.alpha = 0
        return textField
    }()
    
    private lazy var passwordTextField: WaterTextField = {
        let textField = signInView.entryFields.passwordTextField
        textField.alpha = 0
        return textField
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupView()
        makeConstraints()
        bind()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Ups and down view with keyboard (Method from UIVC extension)
        startObservingKeyboard(offset: 200)
        
        // Hiding the keyboard by tapping the screen
        setupGestureRecognizers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startShowAnimation()
    }
}

// MARK: - Private Methods

private extension SignInVC {
    private func setupStyle() {
        view.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.8235294118, blue: 1, alpha: 1)
        view.tintColor = .white
    }

    // MARK: - Setup View
    
    private func setupView() {
        [signInView].forEach(view.addSubview)
    }
    
    // MARK: - Constraints
    
    private func makeConstraints() {
        signInView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bindings
    
    private func bind() {
        signUpButton.addAction(UIAction(handler: { [weak self] _ in
            self?.signUpButton.animateClick {
                self?.sheetPresentVC(named: SignUpVC())
            }
        }), for: .touchUpInside)
        
        forgotPassButton.addAction(UIAction(handler: { [weak self] _ in
            self?.forgotPassButton.animateClick {
                self?.sheetPresentVC(named: ForgotPassVC())
            }
        }), for: .touchUpInside)
        
        signInButton.addAction(UIAction(handler: { [weak self] _ in
            self?.signInButton.animateClick {
                self?.authUser()
            }
        }), for: .touchUpInside)
    }
    
    // Verifying user authorisation data
    private func authUser() {
        guard let email = signInView.entryFields.emailTextField.text,
              let password = signInView.entryFields.passwordTextField.text,
              !email.isEmpty
        else {
            showError(forLabel: signInView.entryFields.warningLabel, withText: "Please enter Email")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                if let err = error {
                    switch err.localizedDescription {
                    case "The password is invalid or the user does not have a password.":
                        self?.showError(forLabel: self?.warningLabel, withText: "Incorrect password")
                    case "There is no user record corresponding to this identifier. The user may have been deleted.":
                        self?.showError(forLabel: self?.warningLabel, withText: "User does not exist")
                    default:
                        self?.showError(forLabel: self?.warningLabel, withText: err.localizedDescription)
                    }
                } else {
                    self?.presentVC(named: TabBarController())
                }
            }
        }
    }

    // Animated showing of background waves
    private func startShowAnimation() {
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.signInView.background.constraintsShowAnimation()
            
            self?.signInView.appLogo.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-200)
                make.width.equalTo(360)
                make.height.equalTo(160)
            }
            self?.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.signInView.background.startWaveAnimation()
            
            UIView.animate(withDuration: 0.5) {
                self?.emailTextField.alpha = 1
                self?.passwordTextField.alpha = 1
                self?.signInButton.alpha = 1
                self?.signUpButton.alpha = 1
                self?.forgotPassButton.alpha = 1
            }
        })
    }
}

// MARK: - UITextFieldDelegate

extension SignInVC: UITextFieldDelegate {
    // Limits max number of characters that can be entered
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength: Int
            
        switch textField {
        case passwordTextField:
            maxLength = 25
        default:
            maxLength = 30
        }
        
        let currentString: NSString = textField.text as NSString? ?? ""
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    // Actions after pressing return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
            authUser()
        }
        
        return true
    }
}
