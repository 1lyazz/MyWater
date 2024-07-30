//  SignUpFields.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class SignUpFields: UIView {
    
    // MARK: - UI Elements

    let emailTextField: WaterTextField = {
        let textField = WaterTextField()
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        return textField
    }()

    let passwordTextField: WaterTextField = {
        let textField = WaterTextField()
        textField.keyboardType = .default
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        textField.isSecureTextEntry = true
        textField.showEyeButton()
        return textField
    }()

    let confirmPasswordField: WaterTextField = {
        let textField = WaterTextField()
        textField.keyboardType = .default
        textField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        textField.isSecureTextEntry = true
        textField.showEyeButton()
        return textField
    }()

    let warningLabel: UILabel = {
        let label = UILabel()
        label.setLabelStyle(font: .systemFont(ofSize: 18), textColor: .white)
        label.numberOfLines = 2
        label.text = "Error"
        label.alpha = 0
        return label
    }()

    let doneButton: UIButton = {
        let button = UIButton()
        button.setAppButtonStyle(backgroundImage: "doneButton")
        return button
    }()

    let signUpLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .signUpLogo
        return imageView
    }()

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        setupView()
        setupViewConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension SignUpFields {
    private func setupView() {
        [signUpLogo, emailTextField, passwordTextField, confirmPasswordField, warningLabel, doneButton].forEach(addSubview)
    }

    private func setupViewConstraints() {
        signUpLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(80)
            make.width.equalTo(250)
            make.height.equalTo(160.7)
        }

        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpLogo.snp.bottom).offset(70)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }

        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }

        confirmPasswordField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }

        warningLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(confirmPasswordField.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(20)
        }

        doneButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(confirmPasswordField.snp.bottom).offset(55)
            make.width.equalTo(150)
            make.height.equalTo(48)
        }
    }
}
