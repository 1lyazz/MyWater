//  CalendarView.swift
//  MyWater
//  Created by Ilya Zablotski

import Firebase
import FSCalendar
import SnapKit
import UIKit

final class CalendarView: UIView {
    
    // MARK: - UI Elements

    let goalStatictic = GoalStatistic()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.myWaterCalendar()
        return calendar
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = #colorLiteral(red: 0.3443033695, green: 0.1750347018, blue: 0.9168830514, alpha: 1)
        view.addShadow()
        return view
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
}

// MARK: - Private Methods

private extension CalendarView {
    private func setupView() {
        addSubview(scrollView)
        [calendar, contentView].forEach(scrollView.addSubview)
        contentView.addSubview(goalStatictic)
    }

    private func setupViewConstraints() {
        calendar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(40)
            make.width.equalToSuperview().inset(10)
            make.height.equalTo(300)
        }

        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(40)
        }

        contentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.width.equalTo(scrollView)
            make.top.equalTo(scrollView).inset(310)
            make.height.equalTo(600)
        }

        goalStatictic.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
