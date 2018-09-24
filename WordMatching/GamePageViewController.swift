//
//  GamePageViewController.swift
//  WordMatching
//
//  Created by Arvin Quiliza on 7/25/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit

let fruitsToGuess = ["apple", "watermelon", "strawberry", "pineapple", "banana", "grapes", "orange", "mango"]
let animalsToGuess = ["lion", "tiger", "elephant", "kangaroo", "penguin", "sheep", "koala", "giraffe"]
let vehiclesToGuess = ["car", "truck", "airplane", "train", "bus", "motorcycle", "boat", "helicopter"]

class GamePageViewController: UIViewController {
    
    //MARK:- IBOUTLETS
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordToGuessLabel: UILabel!
    @IBOutlet var yourGuessButtons: [UIButton]!
    
    //MARK:- VARIABLES
    var shuffledWordsToGuess = [String]()
    var currentGame: Game!
    var currentScore: Int = 0
    var currentHighScore: Int = 0
    var gameType: String = ""
    var wordsToGuess = [String]()
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch gameType {
            case "fruit": wordsToGuess = fruitsToGuess
            case "animal": wordsToGuess = animalsToGuess
            case "vehicle": wordsToGuess = vehiclesToGuess
            default: wordsToGuess = [String]()
        }
        
        newGame()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for button in yourGuessButtons {
            button.imageView?.contentMode = .scaleAspectFill
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- IBACTIONS
    /**
     This function progresses the game. It validates whether the button selected is the same as the word being flashed
     and updates the highscore if the current has been surpassed. It then calls the next word through newWord() function.
     */
    @IBAction func buttonTapped(_ sender: UIButton) {
        if let buttonTitle = sender.currentTitle {
            currentScore = currentGame.validate(using: buttonTitle)
            currentHighScore = currentGame.highScore
        }
        newWord()
    }
    
    /**
     This function is called when info button at the top of the game is tapped. It displays the mechanics of the game.
     */
    @IBAction func infoTapped(_ sender: Any) {
        AlertView.showInfoAlert(on: self, andUse: gameType)
    }

    /**
     This function is called when cancel button at the top of the game is tapped. It calls the **AlertView** struct to confirm
     whether the user really wants to cancel progress or continue to play the game. When the user cancels, their
     current score will be their highscore should they surpass their current high.
     */
    @IBAction func cancelTapped() {
        AlertView.showCancelAlert(on: self, andUse: gameType)
    }
    
    //MARK:- FUNCTIONS
    /**
     This function is called for every start of the game and shuffles the list of words to be played.
     */
    func newGame() {        
        shuffledWordsToGuess = Game.shuffle(stringArray: wordsToGuess)
        currentScore = 0
        newWord()
    }
    
    /**
     This function is executed for each new word that appears on the screen. It checks whether
     there are still some words left for guessing. If words are already exhausted,
     it prompts an alert showing if you will continue to play or return to main menu.
     */
    func newWord() {
        if !shuffledWordsToGuess.isEmpty {
            let toGuess = shuffledWordsToGuess.removeFirst()
            //let reducedWords = shuffledWordsToGuess.filter{$0 != toGuess}
            
            currentGame = Game(currentWord: toGuess, score: currentScore, highScore: currentHighScore, guessType: gameType)
            updateLabels()
            
        } else {
            
            currentGame.score = currentScore
            currentGame.highScore = currentScore > currentHighScore ? currentScore : currentHighScore
            updateLabels()
            
            showGameOverAlert()
        }
    }

    /**
     This function updates the current word and the game's current and highscore.
     */
    func updateLabels() {
        highScoreLabel.text = "High Score: \(currentGame.highScore)"
        scoreLabel.text = "Score: \(currentGame.score)"
        wordToGuessLabel.text = "\(currentGame.currentWord)"
    }
    
    /**
     This function sets up the alert and present it user.
     */
    func showGameOverAlert() {

        var promptTitle = ""
        if currentGame.score == wordsToGuess.count {
            promptTitle = "Perfect!"
        } else if currentGame.score > (wordsToGuess.count / 2) {
            promptTitle = "Great Job!"
        } else if currentGame.score <= (wordsToGuess.count / 2) {
            promptTitle = "Try again!"
        }
        
        AlertView.showGameOverAlert(on: self, andUse: gameType, title: promptTitle)
        
    }
    
    /**
     This function returns to main menu using segue identifier.
     */
    func returnToMain() {
        //dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: gameType, sender: self)
    }
    
    //MARK:- SEGUE
    /* In a storyboard-based application, you will often want to do a little preparation before navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuVC = segue.destination as! ViewController
        
        switch gameType {
            case "fruit" : menuVC.fruitScore = currentHighScore
            case "animal": menuVC.animalScore = currentHighScore
            case "vehicle": menuVC.vehicleScore = currentHighScore
            default: print()
        }
    }
    
    

}
