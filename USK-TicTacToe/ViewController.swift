//
//  ViewController.swift
//  USK-TicTacToe
//
//  Created by Soaurabh Kakkar on 18/07/16.
//  Copyright © 2016 Soaurabh Kakkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var boardState = [0, 0, 0, 0, 0, 0, 0, 0, 0] // board state can be 0/1/2
    var isNoughtsTurn = true //initially would be true
    var isGameActive = true //initially would be true
    let winningCombinations = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    var gameCount = 0 //initially game count is zero
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var replayBtn: UIButton!
    
    @IBAction func playAgain(sender: AnyObject) {
        boardState = [0, 0, 0, 0, 0, 0, 0, 0, 0] // board state can be 0/1/2
        isNoughtsTurn = true //initially would be true
        isGameActive = true //initially would be true
        gameCount = 0
        //set images to nil for all the buttons
        for i in 1...9 {
            if let button = self.view.viewWithTag(i) as? UIButton {
                button.setImage(nil, forState: UIControlState.Normal)
            }
        }
        resultLabel.text = ""
        resultLabel.alpha = 0.0
        replayBtn.alpha = 0.0
    }
    @IBAction func buttonTapped(sender: AnyObject) {
        
        if let button = sender as? UIButton {
            
            if !isGameActive {
                return
            }
            
            //button.tag varies from 1-9
            if isNoughtsTurn && boardState[button.tag - 1] == 0 {
                
                boardState[button.tag - 1] = 1
                
                gameCount += 1
                
                button.setImage(UIImage(named: "nought.png"), forState: UIControlState.Normal)
                
                checkForWinOrDraw(isNoughtsTurn);
                
                isNoughtsTurn = false
                
                
            } else if !isNoughtsTurn && boardState[button.tag - 1] == 0 {
                
                boardState[button.tag - 1] = 2
                
                gameCount += 1
                
                button.setImage(UIImage(named: "cross.png"), forState: UIControlState.Normal)
                
                checkForWinOrDraw(isNoughtsTurn);
                
                isNoughtsTurn = true
                
            }
            
        }
    }
    
    func checkForWinOrDraw(isNoughtsTurn:Bool) {
        
        if isNoughtsTurn {
            //check if player one wins the game
            isPlayerWon(1);
            
        } else{
            //check if player two wins the game
            isPlayerWon(2);
        }
    }
    
    func isPlayerWon(playerNumber:Int) {
        
        for combination in winningCombinations {
            
            var loopCount = 0
            for x in combination {
                if boardState[x - 1] != playerNumber {
                    break;
                }
                loopCount += 1;
            }
            
            if loopCount == combination.count {
                isGameActive = false
                if playerNumber == 1 {
                    resultLabel.text = "Noughts have won"
                } else {
                    resultLabel.text = "Crosses have won"
                }
                
                resultLabel.alpha = 1.0
                replayBtn.alpha = 1.0
            
                break;
            }
        }
        
        if gameCount == 9 && isGameActive {
            isGameActive = false

            resultLabel.text = "It's a draw"
            resultLabel.alpha = 1.0
            replayBtn.alpha = 1.0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        resultLabel.alpha = 0.0
        replayBtn.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

