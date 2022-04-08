//
//  Background.swift
//  connectFour
//
//  Created by 方仕賢 on 2022/4/7.
//

import Foundation
import UIKit
import AVFoundation


    
    



class Background {
    func makeACircle(x: CGFloat, y: CGFloat, radius: CGFloat, color: UIColor) -> CAShapeLayer {
        let circle = UIBezierPath()
        circle.addArc(withCenter: CGPoint(x: x, y: y), radius: radius, startAngle: CGFloat.pi*2, endAngle: CGFloat.pi*0, clockwise: true)
        let layer = CAShapeLayer()
        layer.path = circle.cgPath
        layer.fillColor = color.cgColor
        return layer
    }
    
    func emit(shapeLayer: CGImage, x: CGFloat) -> CAEmitterLayer{
        let emitter = CAEmitterCell()
        emitter.velocity = CGFloat.random(in: 0...1)
        emitter.duration = 20
        emitter.birthRate = 5
        emitter.contents = shapeLayer
        emitter.yAcceleration = 100
        
        let layer = CAEmitterLayer()
        layer.emitterCells = [emitter]
        layer.emitterPosition = CGPoint(x: x, y: 10)
        
        return layer
    }
}
