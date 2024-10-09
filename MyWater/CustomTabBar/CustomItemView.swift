//  CustomItemView.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class CustomItemView: UIView {
    
    private let nameLabel = UILabel()
    private let iconImageView = UIImageView()
    private let underlineView = UIView()
    private let containerView = UIView()
    let index: Int
    
    var isSelected = false {
        didSet {
            animateItems()
        }
    }
    
    private let item: CustomTabItem
    
    // MARK: - Init
    
    init(with item: CustomTabItem, index: Int) {
        self.item = item
        self.index = index
        
        super.init(frame: .zero)
        
        setupView()
        makeConstraints()
        setupProperties()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubviews(nameLabel, iconImageView, underlineView)
    }
    
    // MARK: - Constraints
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.top.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top)
            make.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(16)
        }
        
        underlineView.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(4)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(nameLabel.snp.centerY)
        }
    }
    
    // MARK: - Setup Properties
    
    private func setupProperties() {
        nameLabel.configureWith(item.name,
                                color: .white.withAlphaComponent(0.4),
                                alignment: .center,
                                size: 11,
                                weight: .semibold)
        underlineView.backgroundColor = .white
        underlineView.setupCornerRadius(2)
        
        iconImageView.image = isSelected ? item.selectedIcon : item.icon
    }
    
    // MARK: - Methods
    
    private func animateItems() {
        UIView.animate(withDuration: 0.4) { [unowned self] in
            self.nameLabel.alpha = self.isSelected ? 0.0 : 1.0
            self.underlineView.alpha = self.isSelected ? 1.0 : 0.0
        }
        UIView.transition(with: iconImageView,
                          duration: 0.4,
                          options: .transitionCrossDissolve)
        { [unowned self] in
            self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.icon
        }
    }
}
