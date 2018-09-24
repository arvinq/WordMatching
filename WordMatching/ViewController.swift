//
//  ViewController.swift
//  WordMatching
//
//  Created by Arvin Quiliza on 7/25/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet weak var fruitsScoreLabel: UILabel!
    @IBOutlet weak var animalsScoreLabel: UILabel!
    @IBOutlet weak var vehiclesScoreLabel: UILabel!
    @IBOutlet var mainMenuButtons: [UIButton]!
    
    //MARK:- VARIABLES
    var fruitScore = 0
    var animalScore = 0
    var vehicleScore = 0
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        //navigation bar background color
        navigationController?.navigationBar.barTintColor = .black
        //navigation bar buttons color
        navigationController?.navigationBar.tintColor = .white
        //navigation bar title color
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        updateHighScore()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        for button in mainMenuButtons {
            button.imageView?.contentMode = .scaleAspectFill
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- SEGUE METHOD
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! GamePageViewController
        
        guard let segueIdentifier = segue.identifier else {
            return
        }
        
        destinationViewController.gameType = segueIdentifier
        
        switch segueIdentifier {
            case "fruit" : destinationViewController.currentHighScore = fruitScore
            case "animal": destinationViewController.currentHighScore = animalScore
            case "vehicle": destinationViewController.currentHighScore = vehicleScore
            default: destinationViewController.currentHighScore = 0
        }
        
    }
    
    
    //MARK:- IBACTION
    @IBAction func unwindToMenu (sender: UIStoryboardSegue)  {
        updateHighScore()
    }
    
    //MARK:- FUNCTION
    /**
     This function updates the high score for each of the game type.
     */
    func updateHighScore() {
        fruitsScoreLabel.text = "Fruits: \(fruitScore)"
        animalsScoreLabel.text = "Animals: \(animalScore)"
        vehiclesScoreLabel.text = "Vehicles: \(vehicleScore)"
    }
    
}

