//  DailyGoalView.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

final class DailyGoalView: UIView {
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
        stepper.addShadow()
        return stepper
    }()
    
    var valueFB: Double? {
        didSet {
            setValueFromFB(goal: valueFB)
        }
    }
    
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

private extension DailyGoalView {
    func setupStyle() {
        setSettingViewStyle()
    }
    
    func setupView() {
        [goalTitleLabel, goalLabel, goalStepper].forEach(addSubview)
    }
    
    func setupViewConstraints() {
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
    
    private func setValueFromFB(goal: Double?) {
        guard let goal = goal else { return }
        self.goalStepper.value = goal
        self.goalLabel.text = "\(Int(goal)) GLASSES"
    }
}
