//  SettingsVC.swift
//  MyWater
//  Created by Ilya Zablotski

import Firebase
import SnapKit
import UIKit

final class SettingsVC: UIViewController {
    
    let settingsModel = SettingsModel()
    let settingsView = SettingsView()
    let glassManager = GlassManager()
    let notiCenter = UNUserNotificationCenter.current()
        
    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupView()
        makeConstraints()
        bind()
        loadData()
        scheduleDailyNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingsView.backgroundWaves.startWaveAnimation()
    }
}

// MARK: Private Methods

private extension SettingsVC {
    private func setupStyle() {
        view.backgroundColor = #colorLiteral(red: 0.06453060359, green: 0.3772945702, blue: 0.9141336083, alpha: 1)
        view.tintColor = .white
    }
    
    private func setupView() {
        view.addSubview(settingsView)
        settingsView.goalView.goalStepper.value = Double(glassManager.currentGoal)
    }
    
    private func makeConstraints() {
        settingsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
        
    private func bind() {
        settingsView.goalView.goalStepper.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            settingsView.goalView.setNewTitle()
        }), for: .touchUpInside)
        
        settingsView.applyButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.settingsView.applyButton.animateClick {
                GlassManager.sharedInstance.currentGoal = Float(self.settingsView.goalView.goalStepper.value)
                self.storeChanges()
            }
        }), for: .touchUpInside)
        
        settingsView.optionsView.resetPassButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.settingsView.optionsView.resetPassButton.animateClick {
                self.sheetPresentVC(named: ForgotPassVC())
            }
        }), for: .touchUpInside)
        
        settingsView.optionsView.signOutButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.settingsView.optionsView.signOutButton.animateClick {
                self.signOutUser()
            }
        }), for: .touchUpInside)
        
        settingsView.optionsView.notificationSwitch.addAction(UIAction(handler: { [weak self] _ in
            self?.handleNotificationSwitchToggle()
        }), for: .touchUpInside)
    }

    private func signOutUser() {
        do {
            try Auth.auth().signOut()
            presentVC(named: SignInVC())
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
            
            let alert = UIAlertController(title: "Sign Out Error",
                                          message: "Could not Sign Out of the account. Please try again.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
