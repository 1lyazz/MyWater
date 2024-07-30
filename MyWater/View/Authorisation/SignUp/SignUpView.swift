//  SignUpView.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class SignUpView: UIView {
    
    // MARK: - UI Elements

    let background = SignUpBackground()
    let entryFields = SignUpFields()

    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setShadow()
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

private extension SignUpView {
    private func setupView() {
        [background, entryFields, backButton].forEach(addSubview)
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
    }
}
