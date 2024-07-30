//  OptionsView.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class OptionsView: UIView {
    
    // MARK: - UI Elements

    private let reminderLabel: UILabel = {
        let label = UILabel()
        label.text = "Daily Reminders"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.addShadow()
        return label
    }()
    
    let notificationSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.addShadow()
        return switcher
    }()
    
    let resetPassButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset Password", for: .normal)
        button.titleLabel?.setLabelStyle(font: UIFont.boldSystemFont(ofSize: 24), textColor: .white)
        button.addShadow()
        return button
    }()
    
    let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.setLabelStyle(font: UIFont.boldSystemFont(ofSize: 24), textColor: .red)
        button.addShadow()
        return button
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setSettingViewStyle()
        setupView()
        setupViewConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension OptionsView {
    private func setupView() {
        [reminderLabel, notificationSwitch, resetPassButton, signOutButton].forEach(addSubview)
    }
    
    private func setupStyle() {
        setSettingViewStyle()
    }
    
    private func setupViewConstraints() {
        reminderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(25)
        }
        
        notificationSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(25)
        }
        
        resetPassButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalTo(reminderLabel.snp.bottom).offset(10)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalTo(resetPassButton.snp.bottom)
        }
    }
}
