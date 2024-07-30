//  ForgotPassVC.swift
//  MyWater
//  Created by Ilya Zablotski

import Firebase
import SnapKit
import UIKit

final class ForgotPassVC: UIViewController {
    
    private let forgotPassView = ForgotPassView()
    private lazy var emailTextField = forgotPassView.entryFields.emailTextField
    private lazy var submitButton = forgotPassView.entryFields.submitButton
    private lazy var warningLabel = forgotPassView.entryFields.warningLabel
    private lazy var backButton = forgotPassView.backButton
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupView()
        makeConstraints()
        bind()
        
        emailTextField.delegate = self
        
        // Ups and down view with keyboard (Method from UIVC extension)
        startObservingKeyboard()
        
        // Hiding the keyboard by tapping the screen
        setupGestureRecognizers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        forgotPassView.background.startWaveAnimation()
    }
}

// MARK: Private Methods

private extension ForgotPassVC {
    private func setupStyle() {
        view.backgroundColor = #colorLiteral(red: 0.3443033695, green: 0.1750347018, blue: 0.9168830514, alpha: 1)
        view.tintColor = .white
    }
    
    // MARK: Setup View
    
    private func setupView() {
        view.addSubview(forgotPassView)
    }

    // MARK: Constraints
    
    private func makeConstraints() {
        forgotPassView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Bindings
    
    private func bind() {
        backButton.addAction(UIAction(handler: { [weak self] _ in
            self?.backButton.animateClick {
                self?.dismiss(animated: true, completion: nil)
            }
        }), for: .touchUpInside)
        
        submitButton.addAction(UIAction(handler: { [weak self] _ in
            self?.submitButton.animateClick {
                self?.resetPassword()
            }
        }), for: .touchUpInside)
    }
    
    // MARK: Methods
    
    // Varificatiom email and reset user password
    private func resetPassword() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showError(forLabel: warningLabel, withText: "Enter an email!")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                self?.showError(forLabel: self?.warningLabel, withText: error.localizedDescription)
            } else {
                let alertController = UIAlertController(title: "Password reset email sent", message: "If your email matches one in our database, we will send you the link to reset your password", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alertController, animated: true, completion: nil)
                self?.warningLabel.alpha = 0
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension ForgotPassVC: UITextFieldDelegate {
    // Actions after pressing return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        resetPassword()
    
        return true
    }
}
