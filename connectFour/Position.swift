//
//  Position.swift
//  connectFour
//
//  Created by 方仕賢 on 2022/4/5.
//

import Foundation
import UIKit

//紀錄棋子的位置

class Chess {
    var player1 = [(Int, Int)]()
    var player2 = [(Int, Int)]()
    
    var columns = [244, 302, 359, 417, 475, 532, 590]
    var rows = [58, 115, 173, 230, 288, 346]
    var hiddenButtons = [Bool](repeating: false, count: 7)

    private var column1 = [Int](repeating: 0, count: 6)
    private var column2 = [Int](repeating: 0, count: 6)
    private var column3 = [Int](repeating: 0, count: 6)
    private var column4 = [Int](repeating: 0, count: 6)
    private var column5 = [Int](repeating: 0, count: 6)
    private var column6 = [Int](repeating: 0, count: 6)
    private var column7 = [Int](repeating: 0, count: 6)
    
    var settledPieces = [UILabel]()
    var player1SettlePieces = [UILabel]()
    var player2SettlePieces = [UILabel]()
    
    func update() {
        player1 = []
        player2 = []
        
        hiddenButtons = [Bool](repeating: false, count: 7)
        player1SettlePieces = []
        player2SettlePieces = []
        
        column1 = [Int](repeating: 0, count: 6)
        column2 = [Int](repeating: 0, count: 6)
        column3 = [Int](repeating: 0, count: 6)
        column4 = [Int](repeating: 0, count: 6)
        column5 = [Int](repeating: 0, count: 6)
        column6 = [Int](repeating: 0, count: 6)
        column7 = [Int](repeating: 0, count: 6)
    }
    
    func searchSettledPieces(at index: Int) -> UILabel {
        return settledPieces[index]
    }
    
    func makeAChess(fromX x: Int, fromY y: Int, use emoji: String, currentState: gameState) -> UILabel {
        let chess = UILabel(frame: CGRect(x: x, y: y, width: 60, height: 60))
        chess.font = UIFont.systemFont(ofSize: 55)
        chess.text = emoji
        
        if currentState == .player1 {
            player1SettlePieces.append(chess)
        } else if currentState == .player2 {
            player2SettlePieces.append(chess)
        }
        
        settledPieces.append(chess)
        return chess
    }
    
    func drop(dropTo destination: Int, use chess: UILabel) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
                chess.frame = chess.frame.offsetBy(dx: 0, dy: CGFloat(destination-4))
        }
        
    }
    
    //選擇列數
    func chooseBlock(column: Int, player: Int) -> (Int, Int) {
        var y = 0
        var x = 0
        
        switch column {
        case 1:
            for _ in 0...5 {
                if y <= 4 {
                    if column1[y+1] == 0 {
                        y += 1
                    } else {
                        continue
                    }
                }
            }
            x = 0
            if player == 1 {
                column1[y] = 1
            } else if player == 2 {
                column1[y] = 2
            }
            
            if !column1.contains(0) {
                hiddenButtons[0] = true
            }
        case 2:
            for _ in 0...5 {
                if y <= 4 {
                    if column2[y+1] == 0 {
                        y += 1
                    } else {
                        continue
                    }
                }
            }
            x = 1
            if player == 1 {
                column2[y] = 1
            } else if player == 2 {
                column2[y] = 2
            }
            
            if !column2.contains(0) {
                hiddenButtons[1] = true
            }
        case 3:
            for _ in 0...5 {
                if y <= 4 {
                    if column3[y+1] == 0 {
                        y += 1
                    } else {
                        continue
                    }
                }
            }
            x = 2
            if player == 1 {
                column3[y] = 1
            } else if player == 2 {
                column3[y] = 2
            }
            
            if !column3.contains(0) {
                hiddenButtons[2] = true
            }
        case 4:
            for _ in 0...5 {
                if y <= 4 {
                    if column4[y+1] == 0 {
                        y += 1
                    } else {
                        continue
                    }
                }
            }
            x = 3
            if player == 1 {
                column4[y] = 1
            } else if player == 2 {
                column4[y] = 2
            }
            
            if !column4.contains(0) {
                hiddenButtons[3] = true
            }
            
        case 5:
            for _ in 0...5 {
                if y <= 4 {
                    if column5[y+1] == 0 {
                        y += 1
                    } else {
                        continue
                    }
                }
            }
            x = 4
            
            if player == 1 {
                column5[y] = 1
            } else if player == 2 {
                column5[y] = 2
            }
            
            if !column5.contains(0) {
                hiddenButtons[4] = true
            }
        case 6:
            for _ in 0...5 {
                if y <= 4 {
                    if column6[y+1] == 0 {
                        y += 1
                    } else {
                        continue
                    }
                }
            }
            x = 5
            
            if player == 1 {
                column6[y] = 1
            } else if player == 2 {
                column6[y] = 2
            }
            
            if !column6.contains(0) {
                hiddenButtons[5] = true
            }
        case 7:
            for _ in 0...5 {
                if y <= 4 {
                    if column7[y+1] == 0 {
                        y += 1
                    } else {
                        continue
                    }
                }
            }
            x = 6
            
            if player == 1 {
                column7[y] = 1
            } else if player == 2 {
                column7[y] = 2
            }
            
            if !column7.contains(0) {
                hiddenButtons[6] = true
            }
        default:
            print("No Column // line 67")
        }
        

        //append first chess of the column
        if y == 5 {
            if player == 1 {
                player1.append((x, y))
            } else if player == 2 {
                player2.append((x, y))
            }
        } else {
            
            if player == 1 {
                player1.append((x, y))
            } else if player == 2 {
                player2.append((x, y))
            }
        }
        
        print(player1)
        print(player2)
        
        return (columns[x], rows[y])
    }
    
}
