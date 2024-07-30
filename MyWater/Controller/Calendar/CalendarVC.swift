//  CalendarVC.swift
//  MyWater
//  Created by Ilya Zablotski

import Firebase
import FSCalendar
import SnapKit
import UIKit

final class CalendarVC: UIViewController {
    
    let calendarView = CalendarView()
    let firestore = Firestore.firestore()
    var dateArray: [String] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDates()
        let today = Date()
        calendarView.calendar.select(today)
        retrieveDateData(forDate: formatDate(Date()))
    }
}

// MARK: Private Methods

private extension CalendarVC {
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.3443033695, green: 0.1750347018, blue: 0.9168830514, alpha: 1)
        view.tintColor = .white
        
        calendarView.calendar.dataSource = self
        calendarView.calendar.delegate = self

        view.addSubview(calendarView)
    }
    
    private func makeConstraints() {
        calendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - FSCalendar Delegate & DataSource

extension CalendarVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return dateArray.contains(formatDate(date)) ? 1 : 0
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        retrieveDateData(forDate: formatDate(date))
    }
}
