//  CustomTabBar.swift
//  MyWater
//  Created by Ilya Zablotski

import RxCocoa
import RxGesture
import RxSwift
import UIKit

final class CustomTabBar: UIStackView {
    
    var itemTapped: Observable<Int> { itemTappedSubject.asObservable() }
    
    private let myWaterItem = CustomItemView(with: .myWater, index: 0)
    private let calendarItem = CustomItemView(with: .calendar, index: 1)
    private let settingsItem = CustomItemView(with: .settings, index: 2)
    
    private lazy var customItemViews: [CustomItemView] = [myWaterItem, calendarItem, settingsItem]
    
    private let itemTappedSubject = PublishSubject<Int>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupProperties()
        bind()
        
        setNeedsLayout()
        layoutIfNeeded()
        selectItem(index: 0)
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        addArrangedSubviews([calendarItem, myWaterItem, settingsItem])
    }
    
    // MARK: - Setup Properties
    
    private func setupProperties() {
        distribution = .fillEqually
        alignment = .center
        
        backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        setupCornerRadius(30)
        
        for customItemView in customItemViews {
            customItemView.translatesAutoresizingMaskIntoConstraints = false
            customItemView.clipsToBounds = true
        }
    }
    
    // MARK: - Bindings
    
    private func bind() {
        calendarItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.calendarItem.animateClick {
                    self.selectItem(index: self.calendarItem.index)
                    self.backgroundColor = #colorLiteral(red: 0.3443033695, green: 0.1750347018, blue: 0.9168830514, alpha: 1)
                }
            }
            .disposed(by: disposeBag)
        
        myWaterItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.myWaterItem.animateClick {
                    self.selectItem(index: self.myWaterItem.index)
                    self.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
            .disposed(by: disposeBag)
        
        settingsItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.settingsItem.animateClick {
                    self.selectItem(index: self.settingsItem.index)
                    self.backgroundColor = #colorLiteral(red: 0.06453060359, green: 0.3772945702, blue: 0.9141336083, alpha: 1)
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func selectItem(index: Int) {
        customItemViews.forEach { $0.isSelected = $0.index == index }
        itemTappedSubject.onNext(index)
    }
}
