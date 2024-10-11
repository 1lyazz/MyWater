//  UIVCExtension.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

extension UIViewController {
    
    // Present VC with pageSheet presentation style
    func sheetPresentVC(named viewController: UIViewController) {
        viewController.modalPresentationStyle = .pageSheet
        present(viewController, animated: true, completion: nil)
    }

    // Present VC with fullScreen presentation style
    func presentVC(named viewController: UIViewController) {
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }

    // Starts monitoring the appearance and hiding of the keyboard. Ups and down view with keyboard
    func startObservingKeyboard(offset: Int) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            if self?.view.frame.origin.y == 0 {
                self?.view.frame.origin.y -= keyboardSize.height - CGFloat(offset)
            }
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] _ in
            if self?.view.frame.origin.y != 0 {
                self?.view.frame.origin.y = 0
            }
        }
    }

    // Show error with animation
    func showError(forLabel label: UILabel?, withText text: String) {
        guard let label = label else { return }

        UIView.transition(with: label, duration: 0.5, options: .transitionCrossDissolve, animations: {
            label.alpha = 0
            label.text = text
            label.alpha = 1
        }, completion: nil)
    }

    // Hiding the keyboard by tapping the screen
    func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}
