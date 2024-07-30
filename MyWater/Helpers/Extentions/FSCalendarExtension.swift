//  FSCalendarExtension.swift
//  MyWater
//  Created by Ilya Zablotski

import FSCalendar

extension FSCalendar {
    
    func myWaterCalendar() {
        self.appearance.headerTitleColor = .white
        self.appearance.weekdayTextColor = .white
        self.appearance.titleDefaultColor = .white
        self.appearance.todayColor = #colorLiteral(red: 0.4947434068, green: 0.4069988728, blue: 1, alpha: 1)
        self.appearance.selectionColor = #colorLiteral(red: 0, green: 0.9872947335, blue: 1, alpha: 1)
        self.appearance.titlePlaceholderColor = #colorLiteral(red: 0.4947434068, green: 0.4069988728, blue: 1, alpha: 1)
        
        self.appearance.headerTitleFont = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)
        self.appearance.weekdayFont = UIFont(name: "HelveticaNeue-CondensedBlack", size: 18)
        self.appearance.titleFont = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
        
        self.firstWeekday = 2
        self.addShadow()
        
        let today = Date()
        self.select(today)
    }
}
