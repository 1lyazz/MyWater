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
        let animateWaves = [
            AnimationLayer(layer: firstWave.layer, scaleX: 0.95, scaleY: 0.95),
            AnimationLayer(layer: secondWave.layer, scaleX: 1.1, scaleY: 1.1),
            AnimationLayer(layer: thirdWave.layer, scaleX: 1.1, scaleY: 1.1),
            AnimationLayer(layer: fourthWave.layer, scaleX: 1.2, scaleY: 1.2),
            AnimationLayer(layer: topFirstWave.layer, scaleX: 0.9, scaleY: 0.9),
            AnimationLayer(layer: topSecondWave.layer, scaleX: 1.1, scaleY: 1.1),
            AnimationLayer(layer: topThirdWave.layer, scaleX: 0.9, scaleY: 0.9)
        ]

        WaveAnimator.animateWaves(layers: animateWaves, duration: 3)
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
