//  ForgotPassView.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class ForgotPassView: UIView {
    
    // MARK: - UI Elements

    let background = ResetBackground()
    let entryFields = ResetFields()

    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setShadow()
        return button
    }()

    private let resetPassLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .resetPassLogo
        return imageView
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.setLabelStyle(font: .boldSystemFont(ofSize: 19), textColor: #colorLiteral(red: 1, green: 0.9598634839, blue: 0.9807847142, alpha: 1), textAlignment: .justified, numberOfLines: 5)
        label.text = "Please enter the email address you used during registration. If an account exists, an email will be sent to that address with instructions for resetting your password"
        return label
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

private extension ForgotPassView {
    private func setupView() {
        [background, entryFields, backButton, backButton, resetPassLogo, infoLabel].forEach(addSubview)
    }

    private func setupViewConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        entryFields.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(15)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(15)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }

        resetPassLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(60)
            make.width.equalTo(250)
            make.height.equalTo(173.24)
        }

        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(20)
        }
    }
}
