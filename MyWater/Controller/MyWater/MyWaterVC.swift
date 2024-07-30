////  MyWaterVC.swift
////  MyWater
////  Created by Ilya Zablotski

import Firebase
import SnapKit
import UIKit

class MyWaterVC: UIViewController {
    
    let myWaterView = MyWaterView()
    let firestore = Firestore.firestore()
    var current: Float = 0.0
    var goal: Float = GlassManager.sharedInstance.currentGoal
    
    private let glassManager = GlassManager()
    private var percent: Float = 0.0
    private var date = Date()
    private var currentDateString: String = ""
    private var goalComplete: Bool = false
    
    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupView()
        makeConstraints()
        bind()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.myWaterView.animateSwipeArrows()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myWaterView.background.startWaveAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        date = Date()
        
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy"
        currentDateString = df.string(from: date)

        loadGoalData()
        loadMainData(currentDateString)
    }
    
    // MARK: Methods
    
    // Swipe handler
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard gesture.state == .ended else { return }
            
        let translation = gesture.translation(in: view)
        myWaterView.waterBar.glassStepper.value += translation.y < 0 ? 1 : -1
        updateWaterBar()
    }
    
    private func updateWaterBar() {
        let current = Float(myWaterView.waterBar.glassStepper.value)
        myWaterView.currentLabel.text = String(format: "%.0f/%.0f Glasses", current, goal)
            
        let percent = current / goal
        myWaterView.waterBar.waterBar.setProgress(percent, animated: true)
            
        let startValue = Float(myWaterView.waterBar.percentLabel.text?.replacingOccurrences(of: "%", with: "") ?? "0") ?? 0
        let endValue = percent * 100
        myWaterView.waterBar.animatePercentLabel(from: startValue, to: endValue, duration: 0.5)
            
        goalComplete = percent >= 1.0
        if goalComplete {
            storeGoalCompleteDate(forDate: currentDateString)
        }
            
        sendCurrentValue(current, currentDateString, goalComplete, goal)
    }
}

// MARK: Private Methods

private extension MyWaterVC {
    private func setupView() {
        view.addSubview(myWaterView)
    }
    
    private func setupStyle() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        view.tintColor = .white
    }
    
    private func makeConstraints() {
        myWaterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Bindings
    
    private func bind() {
        myWaterView.waterBar.glassStepper.addAction(UIAction(handler: { [weak self] _ in
            self?.updateWaterBar()
        }), for: .touchUpInside)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
}
