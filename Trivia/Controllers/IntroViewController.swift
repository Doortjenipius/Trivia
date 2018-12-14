//
//  IntroViewController.swift
//  Trivia
//
//  Created by doortje on 10/12/2018.
//  Copyright © 2018 Doortje. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var startGameButton: UIButton!
    
    var highscore: HighScoreItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // Functie die wordt aangeroepen als startGameButton wordt aangeklikt.
    @IBAction func startButtonTapped(_ sender: Any) {
        
        if usernameTextField.text == "" || usernameTextField.text == nil {
            usernameTextField.text = "Please fill in a username"
        } else {
            highscore = HighScoreItem(user: usernameTextField.text!, score: "0")
            performSegue(withIdentifier: "startTrivia", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "startTrivia" {
            let navController = segue.destination as! UINavigationController
            let viewController = navController.topViewController as! QuestionViewController
            viewController.highscoreItem = highscore
        }
    }
    
    @IBAction func unwindToQuizIntroduction(segue:
        UIStoryboardSegue) {
        
    }
    
}

