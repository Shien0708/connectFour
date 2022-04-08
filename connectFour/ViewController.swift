//
//  ViewController.swift
//  connectFour
//
//  Created by 方仕賢 on 2022/4/5.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var plateImageView: UIImageView!
    @IBOutlet var columnButtons: [UIButton]!
    var state: gameState?
    var isComp = false
    var randomIndex = 0
    var currentChess: UILabel?
    var player1Chesses = [(Int, Int)]()
    var player2Chesses = [(Int, Int)]()
    let chess = Chess()
    let checker = Check()
    
    //player info
    @IBOutlet weak var player2DisplaylLabel: UILabel!
    @IBOutlet weak var player1DisplayLabel: UILabel!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player1Points: UILabel!
    @IBOutlet weak var player2Points: UILabel!
    var player1Counts = 0
    var player2Counts = 0
    var player1String = ""
    var player2String = ""
    var player2DisplayString = ""
    var player1DisplayString = ""
    
    @IBOutlet weak var player1ArrowLabel: UILabel!
    @IBOutlet weak var player2ArrowLabel: UILabel!
    
    //result
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    
    //sound
    let player = AVPlayer()
    var url: URL?
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        state = .player1
        player1Label.text = player1String
        player2Label.text = player2String
        player2DisplaylLabel.text = player2DisplayString
        player1DisplayLabel.text = player1DisplayString
    }
    
    func makeSound() {
        url = Bundle.main.url(forResource: "sound-1", withExtension: "mp3")
        let playerItem = AVPlayerItem(url: url!)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    @IBAction func controlVolume(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    @IBAction func set(_ sender: UIButton) {
        if sender == settingButton {
            settingView.isHidden = false
            view.bringSubviewToFront(settingView)
        } else {
            settingView.isHidden = true
        }
    }
    
    func showButtons(show: Bool) {
        if show {
            for i in 0...self.columnButtons.count-1 {
                self.columnButtons[i].isHidden = chess.hiddenButtons[i]
            }
        } else {
            for i in 0...self.columnButtons.count-1 {
                self.columnButtons[i].isHidden = true
            }
        }
    }

    
    @IBAction func settleTheChess(_ sender: UIButton) {
        //find the touched button
        makeSound()
        var touchedButton = 0
        
        // decide computer or player 2 to play
        if isComp && state == .player2 {
            touchedButton = randomIndex
        } else {
            while !columnButtons[touchedButton].isTouchInside {
                print(touchedButton)
                touchedButton += 1
            }
        }
        
        //hide buttons
        showButtons(show: false)
        
        //chess appears
        if state == .player1 {
            currentChess = chess.makeAChess(fromX: chess.columns[touchedButton], fromY: 4, use: player1Label.text!, currentState: state!)
            view.addSubview(currentChess!)
            
        } else if state == .player2 {
            currentChess = chess.makeAChess(fromX: chess.columns[touchedButton], fromY: 4, use: player2Label.text!, currentState: state!)
            view.addSubview(currentChess!)
           
        }
        
        //animation
        view.bringSubviewToFront(plateImageView)
        if state == .player1 {
            chess.drop(dropTo: chess.chooseBlock(column: touchedButton+1, player: 1).1, use: currentChess!).startAnimation()
            player1Chesses.append((chess.columns[touchedButton], chess.rows[(chess.player1.last?.1)!]))
        } else if state == .player2 {
            chess.drop(dropTo: chess.chooseBlock(column: touchedButton+1, player: 2).1, use: currentChess!).startAnimation()
            player2Chesses.append((chess.columns[touchedButton], chess.rows[(chess.player2.last?.1)!]))
        }
        // check whether the state is tie
        if !chess.hiddenButtons.contains(false) {
            state = .tie
            checker.winnerString = "It's a tie!"
        }
        
        //check
        if state == .player1 {
            player1ArrowLabel.isHidden = true
            player2ArrowLabel.isHidden = false
            
            if chess.player1.count >= 4 {
                state = checker.decideState(tuples: checker.checkHasLine(tuples: chess.player1), currentState: state!, isComp: isComp)
            } else {
                state = checker.decideState(tuples: chess.player1, currentState: state!, isComp: isComp)
            }
            
        } else if state == .player2 {
            if chess.player2.count >= 4 {
                state = checker.decideState(tuples: checker.checkHasLine(tuples: chess.player2), currentState: state!, isComp: isComp)
            } else {
                state = checker.decideState(tuples: chess.player2, currentState: state!, isComp: isComp)
            }
            
            player1ArrowLabel.isHidden = false
            player2ArrowLabel.isHidden = true
        }
        
       
        
        if state == .win || state == .tie {
            displayResult()
        } else {
            //buttons appear
            if isComp {
                if state == .player2 {
                    randomIndex = Int.random(in: 0...chess.hiddenButtons.count-1)
                    
                    while chess.hiddenButtons[randomIndex] == true {
                        randomIndex = Int.random(in: 0...chess.hiddenButtons.count-1)
                    }

                    _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                        self.settleTheChess(self.columnButtons[5])
                    })
                    
                } else {
                    _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                        self.showButtons(show: true)
                    })
                    
                }
            } else {
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                    self.showButtons(show: true)
                })
            }
        }
    }
    
    func displayResult() {
        print(checker.fourPieces)
        if let string = checker.winnerString {
            resultLabel.text = string
            if string.contains("1") {
                player1Counts += 1
                for i in checker.fourPieces {
                    chess.player1SettlePieces[i].text = "✅"
                }
            } else if string.contains("2") || string.contains("Computer") {
                player2Counts += 1
                for i in checker.fourPieces {
                    chess.player2SettlePieces[i].text = "✅"
                }
            }
            
        }
        
        
        
        _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.resultView.isHidden = false
                self.view.bringSubviewToFront(self.resultView)
                self.player1Points.text = "\(self.player1Counts)"
                self.player2Points.text = "\(self.player2Counts)"
            }
            animator.startAnimation()
        })
    }
    
    @IBAction func reset(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reset the game", message: "Do you want to reset the game?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.chess.update()
            self.state = .player1
            if self.chess.settledPieces.count > 0 {
                for i in 0...self.chess.settledPieces.count-1 {
                    self.chess.searchSettledPieces(at: i).removeFromSuperview()
                }
            }
            for i in self.columnButtons {
                i.isHidden = false
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        chess.update()
        state = .player1
        for i in 0...chess.settledPieces.count-1 {
            chess.searchSettledPieces(at: i).removeFromSuperview()
        }
        resultView.isHidden = true
        showButtons(show: true)
    }
}
