//  WaveImageView.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

final class WaveImageView: UIImageView {
    
    init(image: UIImage) {
        super.init(image: image)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
