//  DailyGoalView.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class DailyGoalView: UIView {
    
    var goalFromFB: Double? {
        didSet {
            setGoalFromFB(goal: goalFromFB)
        }
    }
    
    // MARK: - UI Elements
    
    private let goalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "DAILY GOAL"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)
        label.addShadow()
        return label
    }()
    
    private let goalLabel: UILabel = {
        let label = UILabel()
        label.text = "0 GLASSES"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 24)
        label.addShadow()
        return label
    }()
    
    let goalStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.tintColor = .white
        stepper.setDecrementImage(stepper.decrementImage(for: .normal)?.withTintColor(.white), for: .normal)
        stepper.setIncrementImage(stepper.incrementImage(for: .normal)?.withTintColor(.white), for: .normal)
        stepper.addShadow()
        return stepper
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupStyle()
        setupView()
        setupViewConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNewTitle() {
        goalLabel.text = "\(Int(goalStepper.value)) GLASSES"
    }
}

// MARK: - Private Methods

private extension DailyGoalView {
    private func setupView() {
        [goalTitleLabel, goalLabel, goalStepper].forEach(addSubview)
    }
    
    private func setupStyle() {
        setSettingViewStyle()
    }
    
    private func setupViewConstraints() {
        goalTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(25)
        }
        
        goalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalTo(goalTitleLabel.snp.bottom).offset(25)
        }
        
        goalStepper.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.top.equalTo(goalTitleLabel.snp.bottom).offset(25)
        }
    }
    
    private func setGoalFromFB(goal: Double?) {
        guard let goal = goal else { return }
        goalStepper.value = goal
        goalLabel.text = "\(Int(goal)) GLASSES"
    }
}
