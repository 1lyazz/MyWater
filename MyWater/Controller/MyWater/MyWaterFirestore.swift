//  MyWaterFirestore.swift
//  MyWater
//  Created by Ilya Zablotski

import Firebase
import SnapKit
import UIKit

extension MyWaterVC {
    
    // Ensure the current user is authenticated and get their email
    private func getCurrentUserEmail() -> String? {
        return Auth.auth().currentUser?.email
    }
    
    // Get Firestore document reference
    private func getDocumentRef(collection: String, document: String) -> DocumentReference {
        return firestore.collection(collection).document(document)
    }
    
    // Saving the date of goal achievement in Firestore
    func storeGoalCompleteDate(forDate date: String) {
        guard let currentUser = getCurrentUserEmail() else { return }
        
        let mainCollection = constants.firebase.mainDataCollection
        
        getDocumentRef(collection: mainCollection, document: currentUser)
            .setData([
                "dates": FieldValue.arrayUnion([date])
            ], merge: true)
    }
    
    // Method to send data to Firestore
    func sendCurrentValue(_ current: Float, _ date: String, _ goalComplete: Bool, _ goal: Float) {
        guard let currentUser = getCurrentUserEmail() else { return }
        
        let data: [String: Any] = [
            constants.firebase.currentCountField: current,
            constants.firebase.dateStringField: date,
            constants.firebase.isGoalComplete: goalComplete,
            constants.firebase.dailyGoalField: goal
        ]
        
        let mainCollection = constants.firebase.mainDataCollection
        let secondDocField = constants.firebase.secondDocField
        
        getDocumentRef(collection: mainCollection, document: currentUser)
            .collection(date)
            .document(secondDocField)
            .setData(data)
    }
    
    // Method loads the goal data (glass volume and daily goal) from Firestore settings
    func loadGoalData() {
        guard let currentUser = getCurrentUserEmail() else { return }
        
        let documentRef = getDocumentRef(collection: constants.firebase.settingsCollection, document: currentUser)
        
        documentRef.getDocument { documentSnapshot, error in
            if let error = error {
                print("Error loading goal data: \(error)")
                return
            }
            
            guard let document = documentSnapshot, let data = document.data(),
                  let currentGoal = data["goal"] as? Float else { return }
            
            DispatchQueue.main.async {
                self.setGoalItems(goal: currentGoal, currentValue: self.current)
            }
            
            self.goal = currentGoal
        }
    }
    
    // Method to load main data from Firestore
    func loadMainData(_ date: String) {
        guard let currentUser = getCurrentUserEmail() else { return }
        
        let documentRef = getDocumentRef(collection: constants.firebase.mainDataCollection, document: currentUser)
            .collection(date)
            .document(constants.firebase.secondDocField)
        
        documentRef.getDocument { documentSnapshot, error in
            if let error = error {
                print("Error loading main data: \(error)")
                return
            }
            
            guard let document = documentSnapshot, let data = document.data(),
                  let currentValue = data["currentCount"] as? Float else { return }
            
            DispatchQueue.main.async {
                self.setGoalItems(goal: self.goal, currentValue: currentValue)
            }
            
            self.current = currentValue
        }
    }
    
    private func setGoalItems(goal: Float, currentValue: Float) {
        let maxPercent: Float = 999.0
        let percent = currentValue / goal
        let percentValue = percent * 100
        
        // Set the progress of the water bar
        myWaterView.waterBar.waterBar.setProgress(percent, animated: true)
        // Update the stepper value
        myWaterView.waterBar.glassStepper.value = Double(currentValue)
        // Update the percent label with a maximum cap of 999%
        myWaterView.waterBar.percentLabel.text = percentValue < maxPercent ? String(format: "%.0f%%", percentValue) : "\(Int(maxPercent))%"
        // Update the current label with the current and goal values
        myWaterView.currentLabel.text = String(format: "%.0f/%.0f Glasses", currentValue, goal)
    }
}
