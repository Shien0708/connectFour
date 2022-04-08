//
//  check.swift
//  connectFour
//
//  Created by 方仕賢 on 2022/4/5.
//

import Foundation


//確認有沒有四顆相連
class Check {
    var winnerString: String?
    var fourPieces = [Int]()
    
    func checkSlashUp(tuples: [(Int, Int)])-> [(Int, Int)] {
        var starters = [(Int, Int)]()
        var newRows = [Int]()
        var newColumns = [Int]()
        var newTuples = [(Int, Int)]()
        var interval = 3
        
        for tuple in tuples {
            newRows.append(tuple.0)
            newColumns.append(tuple.1)
        }
        
        //find starters
        while interval >= 0 {
            for i in 0...tuples.count-1 {
                if newRows[i] == newRows.last!-interval && newColumns[i] == newColumns.last!+interval {
                    starters.append((newRows.last!-interval, newColumns.last!+interval))
                }
            }
            interval -= 1
        }
        
        //find sequence
        interval = 3
        for starter in starters {
            newTuples.removeAll()
            fourPieces.removeAll()
            while interval > 0 {
                for i in 1...tuples.count {
                    if newRows[i-1] == (starter.0+interval) && newColumns[i-1] == (starter.1-interval) {
                        newTuples.append((starter.0+interval, starter.1-interval))
                    }
                }
                interval -= 1
            }
           
            if newTuples.count == 3 {
                newTuples.insert((starters[0].0, starters[0].1), at: 0)
                
                for tuple in 0...3 {
                    var num = 0
                    while tuples[num] != newTuples[tuple] {
                        num += 1
                    }
                    fourPieces.append(num)
                }
               return newTuples
            }
        }
        
        return newTuples
    }

    func checkRow(tuples: [(Int, Int)]) -> [(Int, Int)] {
        var newColumns = [Int]() // x 值
        var newRows = [Int]() // y 值
        var starters = [(Int, Int)]() //可能連線的開始座標
        var newTuples = [(Int, Int)]()//成立連線的新座標
        var interval = 3 //連線間隔
        
        //將 x y 值分開儲存
        for tuple in tuples {
            newColumns.append(tuple.0)
            newRows.append(tuple.1)
        }
        
        //選有可能連線的開始座標
        while interval >= 0 {
            for i in 0...tuples.count-1 {
                if newColumns[i] == (tuples.last?.0)!-interval && newRows[i] == tuples.last!.1 {
                    starters.append((tuples.last!.0-interval, tuples.last!.1))
                }
            }
            interval -= 1
        }
       
        //從每個開始座標確認連線狀況
        interval = 3
        
        for starter in starters {
            newTuples.removeAll()
            fourPieces.removeAll()
            while interval > 0 {
                for i in 1...tuples.count {
                    if newColumns[i-1] == starter.0+interval && newRows[i-1] == starter.1 {
                        newTuples.append((starter.0+interval, starter.1))
                    }
                }
                interval -= 1
            }
            
            if newTuples.count == 3 {
                newTuples.insert(starter, at: 0)
                
                for tuple in 0...3 {
                    var num = 0
                    while tuples[num] != newTuples[tuple] {
                        num += 1
                    }
                    fourPieces.append(num)
                }
                return newTuples
            }
        }
        
        return newTuples
    }

    func checkSlashDown(tuples: [(Int, Int)])-> [(Int, Int)] {
        var starters = [(Int, Int)]()
        var newRows = [Int]()
        var newColumns = [Int]()
        var newTuples = [(Int, Int)]()
        var interval = 3
        
        for tuple in tuples {
            newRows.append(tuple.0)
            newColumns.append(tuple.1)
        }
        
        //find starters
        while interval >= 0 {
            for i in 0...tuples.count-1 {
                if newRows[i] == (newRows.last!-interval) && newColumns[i] == (newColumns.last!-interval) {
                    starters.append((newRows.last!-interval, newColumns.last!-interval))
                }
            }
            interval -= 1
        }
        
        
        //find sequence
        interval = 3
        
        for starter in starters {
            newTuples.removeAll()
            fourPieces.removeAll()
            while interval > 0 {
                for i in 1...tuples.count {
                    if newRows[i-1] == starter.0+interval && newColumns[i-1] == (starter.1+interval) {
                        newTuples.append((starter.0+interval, starter.1+interval))
                    }
                }
                interval -= 1
            }
            
            if newTuples.count == 3 {
                newTuples.insert((starters[0].0, starters[0].1), at: 0)
                
                for tuple in 0...3 {
                    var num = 0
                    while tuples[num] != newTuples[tuple] {
                        num += 1
                    }
                    fourPieces.append(num)
                }
                
               return newTuples
            }
        }
        
        return newTuples
    }

    private func checkColumn(tuples: [(Int, Int)]) -> [(Int, Int)] {
        var newRows = [Int]() // y值
        var newColumns = [Int]()
        var starters = [(Int, Int)]()
        var newTuples = [(Int, Int)]()
        var interval = 3
        
        for tuple in tuples {
            newRows.append(tuple.1)
            newColumns.append(tuple.0)
        }
      
        //pick starters
        while interval >= 0 {
            for i in 0...tuples.count-1 {
                if newRows[i] == ((tuples.last?.1)!-interval) && newColumns[i] == tuples.last?.0 {
                    starters.append((tuples.last!.0, tuples.last!.1-interval))
                }
            }
            interval -= 1
        }
        
        //check four nums sequence
        interval = 3
        for starter in starters {
            newTuples.removeAll()
            fourPieces.removeAll()
            while interval > 0 {
                for i in 1...tuples.count {
                    if newRows[i-1] == (starter.1+interval) && newColumns[i-1] == starter.0 {
                        newTuples.append((starter.0, starter.1+interval))
                    }
                }
                interval -= 1
            }
            
            if newTuples.count == 3 {
                newTuples.insert(starter, at: 0)
                
                for tuple in 0...3 {
                    var num = 0
                    while tuples[num] != newTuples[tuple] {
                        num += 1
                    }
                    fourPieces.append(num)
                }
                return newTuples
            }
        }
        
        return newTuples
    }


    func checkHasLine(tuples: [(Int, Int)]) -> [(Int, Int)] {
        var approaches = 1
        
        while approaches <= 4 {
            switch approaches {
            case 1:
                if checkColumn(tuples: tuples).count == 4 {
                    return checkColumn(tuples: tuples)
                }
            case 2:
                if checkRow(tuples: tuples).count == 4 {
                    return checkRow(tuples: tuples)
                }
            case 3:
                if checkSlashUp(tuples: tuples).count == 4 {
                    return checkSlashUp(tuples: tuples)
                }
                 
            case 4:
                if checkSlashDown(tuples: tuples).count == 4 {
                    return checkSlashDown(tuples: tuples)
                }
            default:
                print("There's no approaches. //line 219")
            }
            approaches += 1
        }
        
        return [(0,0)]
    }

    //決定狀態
    func decideState(tuples: [(Int, Int)], currentState: gameState, isComp: Bool) -> gameState {
        
        if tuples.count == 4 {
            print("\(currentState) wins")
            if currentState == .player1 {
                winnerString = "Player 1 won!"
            } else if currentState == .player2 && !isComp {
                winnerString = "Player 2 won!"
            } else {
                winnerString = "Computer won!"
            }
            return .win
        } else {
            if currentState == .player1 {
                return .player2
            } else if currentState == .player2 {
                return .player1
            }  else if currentState == .tie {
                winnerString = "It's a tie!"
                return .tie
            }
        }
        return .player1 //其他狀態
    }
}

