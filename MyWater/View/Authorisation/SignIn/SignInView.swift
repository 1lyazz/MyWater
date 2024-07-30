//  SignInView.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class SignInView: UIView {
    
    // MARK: - UI Elements

    let background = SignInBackground()
    let entryFields = SignInFields()

    let appLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appLogo
        return imageView
    }()

    let signUpButton: UIButton = {
        let button = UIButton()
        button.setAppButtonStyle(backgroundImage: "signUpButton")
        button.alpha = 0
        return button
    }()

    let forgotPassButton: UIButton = {
        let button = UIButton()
        button.setAppButtonStyle(backgroundImage: "forgotPassButton")
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

private extension SignInView {
    private func setupView() {
        [background, entryFields, signUpButton, forgotPassButton, appLogo].forEach(addSubview)
    }

    private func setupViewConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        entryFields.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        appLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(360)
            make.height.equalTo(160)
        }

        signUpButton.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.width.equalTo(100)
            make.height.equalTo(27.5)
        }

        forgotPassButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.width.equalTo(150)
            make.height.equalTo(53)
        }
    }
}
