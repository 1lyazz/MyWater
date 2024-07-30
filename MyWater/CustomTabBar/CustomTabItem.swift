//  CustomTabItem.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

enum CustomTabItem: String, CaseIterable {
    case myWater
    case calendar
    case settings
}

extension CustomTabItem {
    var viewController: UIViewController {
        switch self {
        case .myWater:
            return MyWaterVC()
        case .calendar:
            return CalendarVC()
        case .settings:
            return SettingsVC()
        }
    }

    var icon: UIImage? {
        switch self {
        case .myWater:
            return UIImage(systemName: "drop.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .settings:
            return UIImage(systemName: "gear.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .calendar:
            return UIImage(systemName: "calendar.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        }
    }

    var selectedIcon: UIImage? {
        switch self {
        case .myWater:
            return UIImage(systemName: "drop.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .settings:
            return UIImage(systemName: "gear.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .calendar:
            return UIImage(systemName: "calendar.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
    }

    var name: String {
        return self.rawValue.capitalized
    }
}
