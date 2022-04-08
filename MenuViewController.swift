//
//  MenuViewController.swift
//  connectFour
//
//  Created by 方仕賢 on 2022/4/7.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    @IBOutlet weak var playerModeButton: UIButton!
    @IBOutlet weak var compModeButton: UIButton!
    
    @IBOutlet var emojiLabels: [UILabel]!
    @IBOutlet var emojiButtons: [UIButton]!
    @IBOutlet weak var playerSegmentedControl: UISegmentedControl!
    var player1String = "🟢"
    var player2String = "🟡"
    var player1Index = 0
    var player2Index = 1
    
    @IBOutlet weak var emojiView: UIView!
    
    var isComp = false
    
    //music
    let player = AVQueuePlayer()
    var url: URL?
    var looper: AVPlayerLooper?
    @IBOutlet weak var pauseButton: UIButton!
    
    let soundPlayer = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playMusic()
        
        emojiButtons[player2Index].isEnabled = false
        emojiLabels[player2Index].backgroundColor = .lightGray
        emojiLabels[player1Index].backgroundColor = .systemGreen
        // Do any additional setup after loading the view.
        var x = 0
        for i in 0...11 {
            let rate = Float.random(in: 0...1)
            x += 70
            circle(x: CGFloat(x),imageIndex: i%6, birthrate: rate)
        }
        view.bringSubviewToFront(playerModeButton)
        view.bringSubviewToFront(compModeButton)
    }
    
    func playMusic() {
        url = Bundle.main.url(forResource: "background", withExtension: "mp3")
        let playerItem = AVPlayerItem(url: url!)
        looper = AVPlayerLooper(player: player, templateItem: playerItem)
        player.play()
    }
    
    @IBAction func play(_ sender: Any) {
        player.play()
        pauseButton.isHidden = true
    }
    
    @IBAction func pause(_ sender: Any) {
        player.pause()
        pauseButton.isHidden = false
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
    
    
    @IBAction func chooseGameMode(_ sender: UIButton) {
        view.bringSubviewToFront(emojiView)
        if sender == compModeButton {
            isComp = true
            playerSegmentedControl.setTitle("Computer", forSegmentAt: 1)
        } else {
            isComp = false
            playerSegmentedControl.setTitle("Player 2", forSegmentAt: 1)
        }
        emojiView.isHidden = false
    }
    
    @IBAction func back(_ sender: Any) {
        emojiView.isHidden = true
    }
    
    @IBAction func chooseEmoji(_ sender: UIButton) {
        var chosenButton = 0
        
        while !emojiButtons[chosenButton].isTouchInside {
            print(chosenButton)
            chosenButton += 1
        }
        
        if playerSegmentedControl.selectedSegmentIndex == 0 {
            emojiLabels[player1Index].backgroundColor = .clear
        } else {
            emojiLabels[player2Index].backgroundColor = .clear
        }
         
        
        if playerSegmentedControl.selectedSegmentIndex == 0 {
            player1String = emojiLabels[chosenButton].text!
            player1Index = chosenButton
            emojiLabels[chosenButton].backgroundColor = .systemGreen
        } else {
            player2String = emojiLabels[chosenButton].text!
            player2Index = chosenButton
            emojiLabels[chosenButton].backgroundColor = .systemGreen
        }
    }
    
    
    @IBAction func choosePlayer(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            emojiButtons[player1Index].isEnabled = true
            emojiLabels[player1Index].backgroundColor = .systemGreen
            emojiButtons[player2Index].isEnabled = false
            emojiLabels[player2Index].backgroundColor = .lightGray
        } else {
            emojiButtons[player1Index].isEnabled = false
            emojiLabels[player1Index].backgroundColor = .lightGray
            emojiButtons[player2Index].isEnabled = true
            emojiLabels[player2Index].backgroundColor = .systemGreen
        }
    }
    

    
    @IBSegueAction func startGame(_ coder: NSCoder) -> ViewController? {
        let controller = ViewController(coder: coder)
        controller?.player1String = player1String
        controller?.player2String = player2String
        controller?.isComp = isComp
        
        if isComp {
            controller?.player1DisplayString = "Player"
            controller?.player2DisplayString = "Computer"
        } else {
            controller?.player1DisplayString = "Player 1"
            controller?.player2DisplayString = "Player 2"
        }
        
        return controller
    }
    
    
    @IBAction func backToHome(segue: UIStoryboardSegue) {
        
        emojiView.isHidden = true
    }
    
}
