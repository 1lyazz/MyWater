//  NotificationManager.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit
import UserNotifications

extension SettingsVC {
    
    // Handles notification toggle switches
    func handleNotificationSwitchToggle() {
        let isOn = settingsView.optionsView.notificationSwitch.isOn
        let title = isOn ? "Are you sure you want to turn on daily notifications?" : "Disable notifications from settings"
        let message = isOn ? "The app will send you a notification daily at 8am to remind you to drink water" : "You will be taken into the system settings for this app, where you can change the notification preferences. Are you sure you want to continue?"

        presentAlert(title: title, message: message) {
            if isOn {
                self.authorizeNotifications()
            } else {
                self.openSettings()
            }
        }
    }
    
    // Alert with header and message
    func presentAlert(title: String, message: String, alertYesClicked: @escaping AlertMethodHandler) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(createNoAction())
        alert.addAction(createYesAction(handler: alertYesClicked))
        
        present(alert, animated: true)
    }
    
    // Requests permission to send notifications
    private func authorizeNotifications() {
        notiCenter.requestAuthorization(options: [.alert, .sound]) { [weak self] granted, _ in
            guard let self = self else { return }
            if granted {
                DispatchQueue.main.async {
                    self.scheduleDailyNotification()
                }
            } else {
                DispatchQueue.main.async {
                    self.showNotificationDeniedAlert()
                }
            }
        }
    }
    
    // Opens the application settings
    private func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
    }

    // Type for the alert method handler
    typealias AlertMethodHandler = () -> Void

    // Creates a "No" action for the alert
    private func createNoAction() -> UIAlertAction {
        return UIAlertAction(title: "No", style: .destructive, handler: { [weak self] _ in
            DispatchQueue.main.async {
                self?.settingsView.optionsView.notificationSwitch.isOn = false
            }
        })
    }

    // Creates a "Yes" action for the alert with the specified handler
    private func createYesAction(handler: @escaping AlertMethodHandler) -> UIAlertAction {
        return UIAlertAction(title: "Yes", style: .default, handler: { _ in
            handler()
        })
    }
    
    // Schedules a daily notification at 8 AM
    func scheduleDailyNotification() {
        // Remove all pending notifications
        notiCenter.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Daily Reminder"
        content.body = "Don't forget to log your consumption and complete your daily goal!"
            
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = 8
        dateComponents.minute = 20
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)
            
        notiCenter.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }

    // Shows an alert if notifications are not allowed
    private func showNotificationDeniedAlert() {
        let notifDenied = UIAlertController(
            title: "Notifications not allowed on this device",
            message: "If you change your mind later, you can change the notification preferences from the system settings for the app.",
            preferredStyle: .alert
        )
        notifDenied.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        present(notifDenied, animated: true)
    }
}
