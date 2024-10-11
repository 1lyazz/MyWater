//  SettingsWavesView.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class SettingsWavesView: UIView {
    
    // MARK: - UI Elements

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
            AnimationLayer(layer: topFirstWave.layer, scaleX: 0.9, scaleY: 0.9),
            AnimationLayer(layer: topSecondWave.layer, scaleX: 1.1, scaleY: 1.1),
            AnimationLayer(layer: topThirdWave.layer, scaleX: 0.9, scaleY: 0.9)
        ]

        WaveAnimator.animateWaves(layers: animateWaves, duration: 3)
    }
}

// MARK: - Private Methods

private extension SettingsWavesView {
    private func setupView() {
        [topFirstWave, topSecondWave, topThirdWave].forEach(addSubview)
    }

    private func setupViewConstraints() {
        setupWaveConstraints(topFirstWave: topFirstWave,
                             topSecondWave: topSecondWave,
                             topThirdWave: topThirdWave)
    }
}
