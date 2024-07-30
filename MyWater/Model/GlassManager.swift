//  GlassManager.swift
//  MyWater
//  Created by Ilya Zablotski

import Firebase
import UIKit

struct GlassManager {
    static var sharedInstance = GlassManager()
    let firestore = Firestore.firestore()

    var currentGoal: Float = 8
    let glassSizes: [String] = ["120", "180", "240", "270", "300", "340", "420", "480"]
}
