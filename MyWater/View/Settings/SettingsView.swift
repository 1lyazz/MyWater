//  SettingsView.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class SettingsView: UIView {
    
    let glassManager = GlassManager()

    // MARK: - UI Elements

    let backgroundWaves = SettingsWavesView()
    private var videoCollection = VideoCollection()
    let goalView = DailyGoalView()
    let glassSizeView = GlassSizeView()
    let optionsView = OptionsView()

    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "SETTINGS"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)
        label.addShadow()
        return label
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = #colorLiteral(red: 0.04743165523, green: 0.4023507237, blue: 0.9706709981, alpha: 1)
        view.addShadow()
        return view
    }()

    let applyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = #colorLiteral(red: 0.06453060359, green: 0.3772945702, blue: 0.9141336083, alpha: 1)
        button.setTitle("APPLY CHANGES", for: .normal)
        button.titleLabel?.setLabelStyle(font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!, textColor: .white)
        button.titleLabel?.addShadow()
        button.addShadow()
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

private extension SettingsView {
    private func setupView() {
        [backgroundWaves, settingsLabel, scrollView].forEach(addSubview)
        scrollView.addSubview(contentView)
        [videoCollection, goalView, glassSizeView, applyButton, optionsView].forEach(contentView.addSubview)
    }

    private func setupViewConstraints() {
        backgroundWaves.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        settingsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(90)
        }
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(40)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.width.equalTo(scrollView)
            make.top.equalTo(scrollView).inset(120)
            make.height.equalTo(1100)
        }
        
        videoCollection.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).inset(40)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(200)
        }
        
        goalView.snp.makeConstraints { make in
            make.top.equalTo(videoCollection.snp.bottom).offset(20)
            make.leading.trailing.equalTo(contentView).inset(24)
            make.height.equalTo(150)
        }
        
        glassSizeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(goalView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(contentView).inset(24)
            make.height.equalTo(250)
        }
        
        applyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(glassSizeView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(contentView).inset(55)
            make.height.equalTo(70)
        }
        
        optionsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(applyButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(contentView).inset(24)
            make.height.equalTo(164)
        }
    }
}
