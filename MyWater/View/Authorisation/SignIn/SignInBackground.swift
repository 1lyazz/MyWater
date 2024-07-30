//  SignInBackground.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class SignInBackground: UIView {
    
    // MARK: - UI Elements

    // Waves for background animation
    private let firstWave = WaveImageView(image: .firstWave)
    private let secondWave = WaveImageView(image: .secondWave)
    private let thirdWave = WaveImageView(image: .thirdWave)
    private let fourthWave = WaveImageView(image: .secondWave)
    private let topFirstWave = WaveImageView(image: .firstWave)
    private let topSecondWave = WaveImageView(image: .secondWave)
    private let topThirdWave = WaveImageView(image: .thirdWave)

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

    // Wave animation
    func startWaveAnimation() {
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.firstWave.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.secondWave.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.thirdWave.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.fourthWave.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.topFirstWave.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.topSecondWave.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.topThirdWave.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }

    func constraintsShowAnimation() {
        firstWave.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(60)
        }

        secondWave.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(110)
        }

        thirdWave.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(150)
        }

        fourthWave.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        topFirstWave.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(-130)
        }

        topSecondWave.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(-150)
        }

        topThirdWave.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(-150)
        }
    }
}

// MARK: - Private Methods

private extension SignInBackground {
    private func setupView() {
        [firstWave, secondWave, thirdWave, fourthWave, topFirstWave, topSecondWave, topThirdWave].forEach(addSubview)
    }

    private func setupViewConstraints() {
        setupWaveConstraints(firstWave: firstWave, secondWave: secondWave, thirdWave: thirdWave, fourthWave: fourthWave,
                             topFirstWave: topFirstWave, topSecondWave: topSecondWave, topThirdWave: topThirdWave)
    }
}
