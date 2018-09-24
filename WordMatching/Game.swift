//
//  Game.swift
//  WordMatching
//
//  Created by Arvin Quiliza on 7/26/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation


struct Game {
    
    //MARK:- PROPERTIES
    var currentWord: String
    var score: Int
    var highScore: Int = 0
    var guessType: String
    
    //MARK:- STATIC AND MUTATING METHODS
    /**
     This function shuffles a string array. It loops through the array, select a new random item
     from it and put it in a new shuffled array.
     - Parameter stringArray: the array to be shuffled
     - Returns: A shuffled String array
     */
    static func shuffle(stringArray:[String]) -> [String] {
        //create a copy of the input array
        var items = stringArray
        
        //our new shuffled array
        var shuffled = [String]();
        
        //iterate through the item array
        for _ in items.enumerated()
        {
            //choose a random number
            let rand = Int(arc4random_uniform(UInt32(items.count)))
            //using that random number, select a random item
            let randomItem = items[rand]
            //append that random item to our new shuffled array
            shuffled.append(randomItem)
            //make sure to remove that item, so we don't pick it again
            items.remove(at: rand)
        }
        return shuffled
    }
    
    
    /**
     This function validates if the button selected is the same as the current word being flashed
     on the screen. If it's a match, increment the current game score and the highscore.
     - Parameter buttonTitle: selected button's title
     - Returns: The current game's score regardless if it's incremented or not.
     */
    mutating func validate(using buttonTitle: String) -> Int{
        if buttonTitle == self.currentWord {
            self.score += 1
            
            self.highScore = self.score > self.highScore ? self.score : self.highScore
            
        }
        
        return self.score
    }
}
