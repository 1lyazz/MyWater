//  MyWaterView.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class MyWaterView: UIView {
    
    // MARK: - UI Elements

    let background = MyWaterBackground()
    let waterBar = WaterBar()

    let currentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 25)
        label.addShadow()
        return label
    }()

    let swipeArrows: UIImageView = {
        let image = UIImageView()
        image.image = .swipeArrows
        image.alpha = 0
        return image
    }()

    let swipeFinger: UIImageView = {
        let image = UIImageView()
        image.image = .swipeFinger
        image.alpha = 0
        return image
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

    func animateSwipeArrows() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.swipeArrows.alpha = 1
            self?.swipeFinger.alpha = 1
        }, completion: { [weak self] _ in
            UIView.animate(withDuration: 1.7, delay: 0, options: [.autoreverse], animations: { [weak self] in
                guard let self = self else { return }
                self.swipeArrows.transform = CGAffineTransform(scaleX: 1.0, y: 3.0)
                self.swipeArrows.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

                let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
                shakeAnimation.fromValue = 0
                shakeAnimation.toValue = 0.2
                shakeAnimation.duration = 0.83
                shakeAnimation.autoreverses = true
                shakeAnimation.repeatCount = .infinity
                self.swipeFinger.layer.add(shakeAnimation, forKey: "shake")
            }, completion: { [weak self] _ in
                UIView.animate(withDuration: 0.3, animations: {
                    self?.swipeArrows.alpha = 0
                    self?.swipeFinger.alpha = 0
                })
            })
        })
    }
}

// MARK: - Private Methods

private extension MyWaterView {
    private func setupView() {
        [background, currentLabel, waterBar, swipeArrows, swipeFinger].forEach(addSubview)
    }

    private func setupViewConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        currentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(waterBar.waterBar.snp.bottom).offset(-15)
        }

        waterBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        swipeArrows.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(249.69)
            make.width.equalTo(100)
        }

        swipeFinger.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(40)
            make.centerY.equalToSuperview().offset(10)
            make.height.equalTo(140)
            make.width.equalTo(140)
        }
    }

    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, \nEEEE"
        return dateFormatter.string(from: Date())
    }
}
