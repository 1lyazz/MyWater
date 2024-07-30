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
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.firstWave.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.secondWave.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.thirdWave.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.fourthWave.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
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
