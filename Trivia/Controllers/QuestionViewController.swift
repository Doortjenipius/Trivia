//
//  ViewController.swift
//  Trivia
//
//  Created by doortje on 10/12/2018.
//  Copyright © 2018 Doortje. All rights reserved.
//

import UIKit
import HTMLString

class QuestionViewController: UIViewController {
    
    // Outlets van de labels en de buttons zodat hier mee gewerkt kan worden.
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    // Slaat op bij welke vraag de quiz is.
    var questionIndex = 0
    // Slaat op wat de score van de user is.
    var score = 0
    // Vragen uit de quiz
    var questionItems = [QuestionItem]()
    var highscoreItem: HighScoreItem!
    var current_Question: QuestionItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetcht QuestionItems
        MenuController.shared.fetchQuestionItems{(questionItem) in
            if let question = questionItem {
                DispatchQueue.main.async {
                    self.updateUI(with: question)
                }
            }
            else {
                print("Hij doet het niet")
            }
        }
    }
    
    func updateUI(with question_items: [QuestionItem]) {
        // Alle items uit QuestionItem worden opgeslagen in questionItems dmv question_items.
        questionItems = question_items
        // Update questionumber label.
        nextQuestion()
    }
    
    
    func nextQuestion() {
        // QuestionIndex telt er 1 bij op nadat nextQuestion weer is aangeroepen, zo wordt bijgehouden bij welke vraag de gebruiker is.
        questionIndex += 1
        if questionIndex < questionItems.count {
            current_Question = questionItems[questionIndex]
            questionLabel.text = current_Question.question.removingHTMLEntities
            updateAnswers(using: current_Question.answers)
            questionNumber.text = "Question number \(questionIndex)"
            scoreLabel.text = "Score = \(score)"
            // Als de questionIndex groter is dan het aantal vragen wordt de Segue uitgevoerd om naar de ResultsViewController te gaan.
        } else {
            performSegue(withIdentifier: "ResultPage", sender: nil)
            
        }
    }
    
    
    func updateAnswers(using answers: [String]) {
        answer1.setTitle(answers[0].removingHTMLEntities, for: .normal)
        answer2.setTitle(answers[1].removingHTMLEntities, for: .normal)
        answer3.setTitle(answers[2].removingHTMLEntities, for: .normal)
        answer4.setTitle(answers[3].removingHTMLEntities, for: .normal)
    }
    
    @IBAction func correctScore(_ sender: UIButton) {
        if sender.currentTitle == current_Question.correct {
            score += 1
            nextQuestion()
        } else {
            // pop up met juiste antwoord.
            nextQuestion()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "ResultPage" {
            let highScoreViewController = segue.destination
                as! HighScoreTableViewController
            highscoreItem.score = String(score)
            highScoreViewController.highscoreItems.append(highscoreItem)
        }
    }
}
