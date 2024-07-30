//  ConstraintsHelper.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

func setupWaveConstraints(firstWave: UIView, secondWave: UIView, thirdWave: UIView, fourthWave: UIView, topFirstWave: UIView, topSecondWave: UIView, topThirdWave: UIView) {
    
    firstWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview().offset(1000)
        make.bottom.equalToSuperview().offset(60)
    }
    
    secondWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview().offset(-1000)
        make.bottom.equalToSuperview().offset(110)
    }
    
    thirdWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview().offset(1000)
        make.bottom.equalToSuperview().offset(150)
    }
    
    fourthWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview().offset(-1000)
        make.bottom.equalToSuperview()
    }
    
    topFirstWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview().offset(1000)
        make.top.equalToSuperview().offset(-130)
    }
    
    topSecondWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview().offset(-1000)
        make.top.equalToSuperview().offset(-150)
    }
    
    topThirdWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview().offset(1000)
        make.top.equalToSuperview().offset(-150)
    }
}

func setupWaveConstraints(firstWave: UIView, secondWave: UIView, thirdWave: UIView) {
    firstWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.bottom.equalToSuperview().offset(160)
    }
    
    secondWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.bottom.equalToSuperview().offset(180)
    }
    
    thirdWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.bottom.equalToSuperview().offset(170)
    }
}

func setupWaveConstraints(firstWave: UIView, secondWave: UIView, thirdWave: UIView, fourthWave: UIView) {
    firstWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.centerY.equalToSuperview()
    }
    
    secondWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.centerY.equalToSuperview()
    }
    
    thirdWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.centerY.equalToSuperview()
    }
    
    fourthWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.centerY.equalToSuperview()
    }
}

func setupWaveConstraints(topFirstWave: UIView, topSecondWave: UIView, topThirdWave: UIView) {
    topFirstWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.top.equalToSuperview().offset(-180)
    }
    
    topSecondWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.top.equalToSuperview().offset(-200)
    }
    
    topThirdWave.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.top.equalToSuperview().offset(-200)
    }
}
