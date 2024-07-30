//  FirebaseManager.swift
//  MyWater
//  Created by Ilya Zablotski

import Firebase
import Toast

extension SettingsVC {
    
    // Loads data for the current user from Firestore
    func loadData() {
        guard let currentUser = Auth.auth().currentUser?.email else { return }
        settingsModel.loadData(forUser: currentUser) { [weak self] goalValue, glassSizeRow, notificationOption in
            DispatchQueue.main.async {
                self?.updateGoalView(with: goalValue)
                self?.updateGlassSizeView(with: glassSizeRow)
                self?.updateNotificationSwitch(with: notificationOption)
            }
        }
    }
    
    private func updateGoalView(with value: Double) {
        settingsView.goalView.goalFromFB = value
    }

    private func updateGlassSizeView(with index: Int) {
        settingsView.glassSizeView.glassSizePicker.selectRow(index, inComponent: 0, animated: true)
    }

    private func updateNotificationSwitch(with option: Bool) {
        settingsView.optionsView.notificationSwitch.isOn = option
    }

    // Saves setting changes in Firestore
    func storeChanges() {
        guard let currentUser = Auth.auth().currentUser?.email else { return }
        let dailyGoal = settingsView.goalView.goalStepper.value
        let glassSize = settingsView.glassSizeView.glassSizePicker.selectedRow(inComponent: 0)
        let notificationOption = settingsView.optionsView.notificationSwitch.isOn
        settingsModel.storeChanges(dailyGoal: dailyGoal, glassSize: glassSize, notificationOption: notificationOption, forUser: currentUser) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error saving settings: \(error)")
                    self.view.makeToast("Settings could not be saved: \(error.localizedDescription)", duration: 3.0, position: .top)
                } else {
                    print("Settings saved successfully")
                    self.view.makeToast("Settings saved successfully", duration: 3.0, position: .top)
                }
            }
        }
    }
}
