//  WaveAnimator.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

struct AnimationLayer {
    let layer: CALayer
    let scaleX: CGFloat
    let scaleY: CGFloat
}

@MainActor
final class WaveAnimator {
    static func animateWaves(layers: [AnimationLayer], duration: CFTimeInterval) {
        for layer in layers {
            animateLayer(layer: layer.layer, scaleX: layer.scaleX, scaleY: layer.scaleY, duration: duration)
        }
    }

    private static func animateLayer(layer: CALayer, scaleX: CGFloat, scaleY: CGFloat, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = CATransform3DIdentity
        animation.toValue = CATransform3DMakeScale(scaleX, scaleY, 1)
        animation.duration = duration
        animation.autoreverses = true
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "waveAnimation")
    }
}
