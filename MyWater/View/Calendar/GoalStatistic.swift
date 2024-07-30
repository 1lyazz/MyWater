//  GoalStatistic.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class GoalStatistic: UIView {
    
    // MARK: - UI Elements

    let goalProgressBar: CircularProgressView = {
        let progressBar = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        return progressBar
    }()

    let goalPercent: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = 0.7
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)
        label.addShadow()
        return label
    }()

    let goalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 25)
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

    // Updating the user interface based on the received data
    func updateUI(currentGoal: Float, goal: Float) {
        DispatchQueue.main.async {
            self.goalLabel.text = String(format: "Consumption: %.0f Glasses", currentGoal)
            let percent = currentGoal / goal
            self.goalProgressBar.setProgress(percent, animated: true)
            self.animateGoalPercent(from: self.goalPercent.text?.replacingOccurrences(of: "%", with: "") ?? "0",
                                    to: String(format: "%.0f", percent * 100))
        }
    }
}

// MARK: - Private Methods

private extension GoalStatistic {
    private func setupView() {
        [goalProgressBar, goalPercent, goalLabel].forEach(addSubview)
    }

    private func setupViewConstraints() {
        goalProgressBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.width.height.equalTo(200)
        }

        goalPercent.snp.makeConstraints { make in
            make.centerX.equalTo(goalProgressBar)
            make.centerY.equalTo(goalProgressBar)
        }

        goalLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(goalProgressBar.snp.bottom).offset(40)
        }
    }

    // Сhange Animation in percentage of goal attainment
    private func animateGoalPercent(from startValue: String, to endValue: String) {
        guard let start = Float(startValue), let end = Float(endValue) else { return }
        let duration: TimeInterval = 1.0
        let steps = abs(end - start)
        let stepDuration = duration / TimeInterval(steps)
        var currentValue = start

        Timer.scheduledTimer(withTimeInterval: stepDuration, repeats: true) { timer in
            currentValue += (start < end ? 1 : -1)
            if (start < end && currentValue >= end) || (start > end && currentValue <= end) {
                currentValue = end
                timer.invalidate()
            }

            self.goalPercent.text = String(format: "%.0f", currentValue) + "%"
        }
    }
}
