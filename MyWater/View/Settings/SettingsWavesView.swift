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
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.topFirstWave.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.topSecondWave.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.topThirdWave.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
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
