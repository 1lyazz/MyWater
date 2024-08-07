//  ResetFields.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class ResetFields: UIView {
    
    // MARK: - UI Elements

    let emailTextField: WaterTextField = {
        let textField = WaterTextField()
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        textField.backgroundColor = #colorLiteral(red: 0.6805114746, green: 0.5969915986, blue: 0.9616741538, alpha: 1)
        return textField
    }()

    let warningLabel: UILabel = {
        let label = UILabel()
        label.setLabelStyle(font: .systemFont(ofSize: 18), textColor: .white)
        label.text = "Error"
        label.alpha = 0
        return label
    }()

    let submitButton: UIButton = {
        let button = UIButton()
        button.setAppButtonStyle(backgroundImage: "submitButton")
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

private extension ResetFields {
    private func setupView() {
        [emailTextField, warningLabel, submitButton].forEach(addSubview)
    }

    private func setupViewConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(200)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }

        warningLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(20)
        }

        submitButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(33)
            make.width.equalTo(150)
            make.height.equalTo(48)
        }
    }
}
