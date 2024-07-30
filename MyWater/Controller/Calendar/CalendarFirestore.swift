//  CalendarFirestore.swift
//  MyWater
//  Created by Ilya Zablotski

import Firebase
import SnapKit
import UIKit

extension CalendarVC {
    
    // Getting data for a specific date from Firebase
    func retrieveDateData(forDate date: String) {
        guard let currentUser = Auth.auth().currentUser?.email else { return }
        
        let documentRef = firestore.collection(constants.firebase.mainDataCollection)
            .document(currentUser)
            .collection(date)
            .document(constants.firebase.secondDocField)
        
        documentRef.getDocument { [weak self] document, _ in
            guard let self = self else { return }
            guard let document = document, document.exists, let data = document.data() else {
                self.calendarView.goalStatictic.updateUI(currentGoal: 0, goal: 1)
                return
            }
            
            let currentGoal = data[constants.firebase.currentCountField] as? Float ?? 0
            let goal = data[constants.firebase.dailyGoalField] as? Float ?? 1
            self.calendarView.goalStatictic.updateUI(currentGoal: currentGoal, goal: goal)
        }
    }
    
    // Getting dates from Firebase
    func getDates() {
        guard let currentUser = Auth.auth().currentUser?.email else { return }
        
        let documentRef = firestore.collection(constants.firebase.mainDataCollection).document(currentUser)
        
        documentRef.getDocument { [weak self] documentSnapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error retrieving document: \(error.localizedDescription)")
                return
            }
            
            guard let document = documentSnapshot, let data = document.data() else {
                print("Document does not exist or data is nil")
                return
            }
            
            guard let dates = data["dates"] as? [String] else {
                print("Dates field is missing or not an array of strings")
                return
            }
            
            self.dateArray = dates
            DispatchQueue.main.async {
                self.calendarView.calendar.reloadData()
            }
        }
    }
    
    // MARK: - Reusable methods
    
    // Formattinп Date to String
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy"
        return df
    }()
    
    func formatDate(_ date: Date) -> String {
        return CalendarVC.dateFormatter.string(from: date)
    }
}

