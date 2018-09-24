//
//  AlertView.swift
//  WordMatching
//
//  Created by Arvin Quiliza on 8/2/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation
import UIKit

struct AlertView {

    //MARK:- PRIVATE METHODS
    /**
         This method sets up the basic alert controller, action and presents it to view
         - Parameter viewController: GamePageViewController
         - Parameter title: The title of the alert message
         - Parameter message: The message body of the alert
         - Parameter userChoice: String array. These represents the choices where user would choose from
     */
    private static func showBasicAlert(on viewController: GamePageViewController, with title: String, message: String, userChoice: [String]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for userWantsTo in userChoice {
            let alertAction = UIAlertAction(title: userWantsTo, style: .default, handler: {
                alertAction in self.doAlert(on: viewController, where: userWantsTo)
            })
            alertController.addAction(alertAction)
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    /**
         This method serves as the handler method when a choice is selected from the alert
         - Parameter viewController: GamePageViewController
         - Parameter userWantsTo: actions that executes what the user have chosen
     */
    private static func doAlert(on viewController: GamePageViewController, where userWantsTo: String) {
        if userWantsTo == "Play again" {
            viewController.newGame()
        } else if userWantsTo == "Return to Main" {
            viewController.returnToMain()
        } else if userWantsTo == "Yes" {
            viewController.returnToMain()
            //navigationController?.popViewController(animated: true)
        }
    }
    
    
    //MARK:- STATIC METHODS
    
    /**
        This method shows an alert when Info button is tapped
         - Parameter viewController: GamePageViewController
         - Parameter gameType: This parameter tells the current type of the game being played
     */
    static func showInfoAlert(on viewController: GamePageViewController, andUse gameType: String) {
        let title = "Match the \(gameType)s"
        let message = "Click the right image to match the \(gameType)s that is being flashed below."
        
        showBasicAlert(on: viewController, with: title, message: message, userChoice: ["OK"])
    }
    
    /**
         This method shows an alert when Cancel button is tapped.
         - Parameter viewController: GamePageViewController
         - Parameter gameType: This parameter tells the current type of the game being played
     */
    static func showCancelAlert(on viewController: GamePageViewController, andUse gameType: String) {
        let title = "Cancel your game?"
        let message = "Are you sure you want to cancel the game? Your score will be your highest if you surpass your current high."
        
        showBasicAlert(on: viewController, with: title, message: message, userChoice: ["Yes", "No"])
        
    }
    
    /**
         This method shows an alert when all of the words have been guessed.
         - Parameter viewController: GamePageViewController
         - Parameter gameType: This parameter tells the current type of the game being played
         - Parameter title: alert's title
     */
    static func showGameOverAlert(on viewController: GamePageViewController, andUse gameType: String, title: String) {
        
        let message = "You got \(viewController.currentScore) \(gameType) correctly. Your highest is \(viewController.currentHighScore). Do you want to play again?"
        
        showBasicAlert(on: viewController, with: title, message: message, userChoice: ["Play again", "Return to Main"])
        
    }
    
    
}
