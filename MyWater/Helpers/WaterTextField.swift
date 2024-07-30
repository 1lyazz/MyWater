//  WaterTextField.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

final class WaterTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        showClearButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Configure WaterTextField appearance
    private func configureAppearance() {
        layer.cornerRadius = 15
        backgroundColor = #colorLiteral(red: 0.4168710113, green: 0.7793537974, blue: 1, alpha: 1)
        tintColor = #colorLiteral(red: 0.7059004903, green: 0.9551807046, blue: 1, alpha: 1)
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        font = UIFont.boldSystemFont(ofSize: 20)
        autocapitalizationType = .none
        textColor = .white
    }

    // Setup clear button to TextField
    private func showClearButton() {
        let clearButton = configureClearButton()

        clearButtonMode = .whileEditing
        rightViewMode = .whileEditing
        rightView = clearButton
    }

    // Show eye button in TextField
    func showEyeButton() {
        let eyeButton = configureEyeButton()
        let clearButton = configureClearButton()

        let stackView = UIStackView(arrangedSubviews: [eyeButton, clearButton])
        stackView.axis = .horizontal
        stackView.spacing = 10

        rightView = stackView
        rightViewMode = .whileEditing
    }

    // Configure clear button appearance
    func configureClearButton() -> UIButton {
        let clearButton = UIButton()
        clearButton.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        clearButton.tintColor = .secondaryLabel
        clearButton.addAction(UIAction(handler: { [weak self] _ in
            clearButton.animateClick {
                self?.text = ""
            }
        }), for: .touchUpInside)

        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        clearButton.configuration = config

        return clearButton
    }

    // Configure eye button appearance
    func configureEyeButton() -> UIButton {
        let eyeButton = UIButton()
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.tintColor = .secondaryLabel
        eyeButton.addAction(UIAction(handler: { [weak self] _ in
            eyeButton.animateClick {
                self?.isSecureTextEntry.toggle()
            }
        }), for: .touchUpInside)

        return eyeButton
    }

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
