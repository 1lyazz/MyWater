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
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.topFirstWave.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.topSecondWave.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.topThirdWave.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

            self.firstWave.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.secondWave.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.thirdWave.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.fourthWave.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
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
