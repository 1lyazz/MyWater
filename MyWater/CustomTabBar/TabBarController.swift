//  TabBarController.swift
//  MyWater
//  Created by Ilya Zablotski

import RxSwift
import SnapKit
import UIKit

final class TabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBar()
    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        makeConstraints()
        setupProperties()
        bind()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: Setup View
    
    private func setupView() {
        view.addSubview(customTabBar)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        customTabBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(24)
            make.height.equalTo(90)
        }
    }
    
    // MARK: Setup Properties
    
    private func setupProperties() {
        tabBar.isHidden = true
        
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.addShadow()
        
        selectedIndex = 0
        let controllers = CustomTabItem.allCases.map { $0.viewController }
        setViewControllers(controllers, animated: true)
        
        setupTabBarAppearance()
    }
    
    // MARK: Bindings
    
    private func bind() {
        customTabBar.itemTapped
            .bind { [weak self] in self?.selectTabWith(index: $0) }
            .disposed(by: disposeBag)
    }
    
    // MARK: Methods
    
    private func selectTabWith(index: Int) {
        selectedIndex = index
    }
    
    private func setupTabBarAppearance() {
        guard #available(iOS 13.0, *) else { return }
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
