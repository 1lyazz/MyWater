//  EntryFields.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class SignInFields: UIView {
    
    // MARK: - UI Elements

    let emailTextField: WaterTextField = {
        let textField = WaterTextField()
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        textField.alpha = 0
        return textField
    }()

    let passwordTextField: WaterTextField = {
        let textField = WaterTextField()
        textField.keyboardType = .default
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        textField.isSecureTextEntry = true
        textField.showEyeButton()
        textField.alpha = 0
        return textField
    }()

    let warningLabel: UILabel = {
        let label = UILabel()
        label.setLabelStyle(font: .systemFont(ofSize: 18), textColor: .white)
        label.numberOfLines = 2
        label.text = ""
        label.alpha = 0
        return label
    }()

    let signInButton: UIButton = {
        let button = UIButton()
        button.setAppButtonStyle(backgroundImage: "signInButton")
        button.alpha = 0
        return button
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

private extension SignInFields {
    private func setupView() {
        [emailTextField, passwordTextField, signInButton, warningLabel].forEach(addSubview)
    }

    private func setupViewConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }

        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(40)
        }

        warningLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
            make.width.equalTo(140)
            make.height.equalTo(48)
        }
    }
}
