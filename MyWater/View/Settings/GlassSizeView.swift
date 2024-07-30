//  GlassSizeView.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class GlassSizeView: UIView {
    
    let glassManager = GlassManager()
    
    // MARK: - UI Elements

    private let glassSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "SIZE OF YOUR GLASS"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)
        label.addShadow()
        return label
    }()
    
    lazy var glassSizePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupStyle()
        setupView()
        setupViewConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension GlassSizeView {
    private func setupView() {
        [glassSizeLabel, glassSizePicker].forEach(addSubview)
    }
    
    private func setupStyle() {
        setSettingViewStyle()
    }
    
    private func setupViewConstraints() {
        glassSizeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
        }
        
        glassSizePicker.snp.makeConstraints { make in
            make.top.equalTo(glassSizeLabel.snp.top).offset(10)
            make.trailing.leading.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UIPickerView

extension GlassSizeView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return glassManager.glassSizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return glassManager.glassSizes[row] + "ml"
    }
}
