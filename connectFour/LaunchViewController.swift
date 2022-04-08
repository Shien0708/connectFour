//
//  LaunchViewController.swift
//  connectFour
//
//  Created by 方仕賢 on 2022/4/8.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var x = 0
        for i in 0...11 {
            let rate = Float.random(in: 0...1)
            x += 70
            circle(x: CGFloat(x),imageIndex: i%6, birthrate: rate)
        }
    }
    

    func circle(x: CGFloat,imageIndex: Int, birthrate: Float) {
        let emitterCell = CAEmitterCell()
        let images = ["red", "yellow", "cyan", "purple", "face-0", "green"]
        emitterCell.contents = UIImage(named: images[imageIndex])?.cgImage
        emitterCell.birthRate = birthrate
        emitterCell.lifetime = 20
        emitterCell.velocity = 50
        emitterCell.yAcceleration = 180
        emitterCell.scale = 0.3
        
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterCells = [emitterCell]
        emitterLayer.position = CGPoint(x: x, y: -20)
        view.layer.addSublayer(emitterLayer)
    }
}
