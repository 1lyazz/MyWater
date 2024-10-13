//  WaterTextField.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

enum FieldType {
    case email
    case password
    case `default`
}

final class WaterTextField: UITextField {
    private var padding: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 35)
    
    init(type: FieldType) {
        super.init(frame: .zero)
        configureAppearance(for: type)
        
        if type == .password {
            showEyeButton()
            self.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 70)
        } else {
            showClearButton()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configure WaterTextField appearance
    private func configureAppearance(for type: FieldType) {
        // Appearance
        layer.cornerRadius = 15
        backgroundColor = #colorLiteral(red: 0.4168710113, green: 0.7793537974, blue: 1, alpha: 1)
        tintColor = #colorLiteral(red: 0.7059004903, green: 0.9551807046, blue: 1, alpha: 1)
        textColor = .white
        font = UIFont.boldSystemFont(ofSize: 20)
        
        // Shadow
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // Placeholder and keyboard settings based on type
        switch type {
            case .email:
                attributedPlaceholder = NSAttributedString(
                    string: "Email",
                    attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
                )
                keyboardType = .emailAddress
            case .password:
                attributedPlaceholder = NSAttributedString(
                    string: "Password",
                    attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
                )
                isSecureTextEntry = true
            case .default:
                attributedPlaceholder = NSAttributedString(
                    string: "Enter text",
                    attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
                )
                keyboardType = .default
        }
        
        autocapitalizationType = .none
        
        // General keyboard settings
        minimumFontSize = 12
        adjustsFontSizeToFitWidth = true
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
    private func configureClearButton() -> UIButton {
        let clearButton = UIButton()
        clearButton.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        clearButton.tintColor = .white
        clearButton.alpha = 0.7
        
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
    private func configureEyeButton() -> UIButton {
        let eyeButton = UIButton()
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.tintColor = .white
        eyeButton.alpha = 0.7
        
        eyeButton.addAction(UIAction(handler: { [weak self] _ in
            eyeButton.animateClick {
                self?.isSecureTextEntry.toggle()
            }
        }), for: .touchUpInside)
        
        return eyeButton
    }
        
    // Text field padding
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
