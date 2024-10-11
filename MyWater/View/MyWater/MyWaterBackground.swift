//  MyWaterBackground.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class MyWaterBackground: UIView {
    
    // MARK: - UI Elements

    // Waves for background animation
    private let firstWave = WaveImageView(image: .firstCircleWave)
    private let secondWave = WaveImageView(image: .secondCircleWave)
    private let thirdWave = WaveImageView(image: .thirdCircleWave)
    private let fourthWave = WaveImageView(image: .firstCircleWave)
    private let topFirstWave = WaveImageView(image: .firstWave)
    private let topSecondWave = WaveImageView(image: .secondWave)
    private let topThirdWave = WaveImageView(image: .thirdWave)

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)
        label.numberOfLines = 0
        label.text = getCurrentDate()
        label.addShadow()
        return label
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

    // Wave animation
    func startWaveAnimation() {
        let animateWaves = [
            AnimationLayer(layer: topFirstWave.layer, scaleX: 0.9, scaleY: 0.9),
            AnimationLayer(layer: topSecondWave.layer, scaleX: 1.1, scaleY: 1.1),
            AnimationLayer(layer: topThirdWave.layer, scaleX: 0.9, scaleY: 0.9),

            AnimationLayer(layer: firstWave.layer, scaleX: 0.95, scaleY: 0.95),
            AnimationLayer(layer: secondWave.layer, scaleX: 1.1, scaleY: 1.1),
            AnimationLayer(layer: thirdWave.layer, scaleX: 1.1, scaleY: 1.1),
            AnimationLayer(layer: fourthWave.layer, scaleX: 1.2, scaleY: 1.2)
        ]

        WaveAnimator.animateWaves(layers: animateWaves, duration: 3)
    }
}

// MARK: - Private Methods

private extension MyWaterBackground {
    private func setupView() {
        [topFirstWave, topSecondWave, topThirdWave, firstWave,
         secondWave, dateLabel, thirdWave, fourthWave].forEach(addSubview)
    }

    private func setupViewConstraints() {
        setupWaveConstraints(topFirstWave: topFirstWave,
                             topSecondWave: topSecondWave,
                             topThirdWave: topThirdWave)

        setupWaveConstraints(firstWave: firstWave,
                             secondWave: secondWave,
                             thirdWave: thirdWave,
                             fourthWave: fourthWave)

        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(80)
        }
    }

    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, \nEEEE"
        return dateFormatter.string(from: Date())
    }
}
