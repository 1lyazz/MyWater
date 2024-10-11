//  ResetBackground.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class ResetBackground: UIView {
    
    // MARK: - UI Elements

    // Waves for background animation
    private let firstWave = WaveImageView(image: .firstWave)
    private let secondWave = WaveImageView(image: .secondWave)
    private let thirdWave = WaveImageView(image: .thirdWave)
    private let fourthWave = WaveImageView(image: .secondWave)

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
            AnimationLayer(layer: fourthWave.layer, scaleX: 1.2, scaleY: 1.2)
        ]

        WaveAnimator.animateWaves(layers: animateWaves, duration: 3)
    }
}

// MARK: - Private Methods

private extension ResetBackground {
    private func setupView() {
        [firstWave, secondWave, thirdWave, fourthWave].forEach(addSubview)
    }

    private func setupViewConstraints() {
        setupWaveConstraints(firstWave: firstWave, secondWave: secondWave, thirdWave: thirdWave, fourthWave: fourthWave)
    }
}
