//
//  File 3.swift
//  MyWater
//
//  Created by Ilya Zablotski on 9.07.24.
//


    private let warningLabel: UILabel = {
        let label = UILabel()
        label.setLabelStyle(font: .systemFont(ofSize: 18), textColor: .red)
        label.text = "Error"
        label.isHidden = true
        label.alpha = 0
        return label
    }()