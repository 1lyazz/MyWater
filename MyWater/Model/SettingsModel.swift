// SettingsModel.swift
// MyWater
// Created by Ilya Zablotski

import Firebase

class SettingsModel {
    private let firestore = Firestore.firestore()

    // MARK: - Load Data

    func loadData(forUser currentUser: String, completion: @escaping (Double, Int, Bool) -> Void) {
        let settingsDocRef = firestore.collection(constants.firebase.settingsCollection).document(currentUser)

        settingsDocRef.getDocument { document, error in
            if let error = error {
                print("Error fetching settings: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists else {
                print("Settings do not currently exist")
                return
            }

            if let goalValue = document[constants.firebase.dailyGoalField] as? Double,
               let glassSizeRow = document[constants.firebase.glassSizeField] as? Int,
               let notificationOption = document[constants.firebase.notificationStatusField] as? Bool {
                completion(goalValue, glassSizeRow, notificationOption)
            }
        }
    }

    // MARK: - Store Changes

    func storeChanges(dailyGoal: Double, glassSize: Int, notificationOption: Bool, forUser currentUser: String, completion: @escaping (Error?) -> Void) {
        let data: [String: Any] = [
            constants.firebase.dailyGoalField: dailyGoal,
            constants.firebase.glassSizeField: glassSize,
            constants.firebase.notificationStatusField: notificationOption,
            constants.firebase.currentUserField: currentUser
        ]

        let settingsDocRef = firestore.collection(constants.firebase.settingsCollection).document(currentUser)
        settingsDocRef.setData(data) { error in
            completion(error)
        }
    }
}
