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
            // Geeft aan wat de huidige vraag is.
            current_Question = questionItems[questionIndex]
            // Text van het label wordt naar de huidige vraag gezet.
            questionLabel.text = current_Question.question.removingHTMLEntities
            // Updateanswers wordt aangeroepen.
            updateAnswers(using: current_Question.answers)
            // Questionnumber label wordt naar het juiste aantal gezet.
            questionNumber.text = "Question number \(questionIndex)"
            // Score label houdt de score bij.
            scoreLabel.text = "Score = \(score)"
            // Als de questionIndex groter is dan het aantal vragen wordt de Segue uitgevoerd om naar de ResultsViewController te gaan.
        } else {
            performSegue(withIdentifier: "ResultPage", sender: nil)
            
        }
    }
    
    // Deze functie zet de titel van de buttons naar de juiste antwoordmogelijkheden.
    func updateAnswers(using answers: [String]) {
        answer1.setTitle(answers[0].removingHTMLEntities, for: .normal)
        answer2.setTitle(answers[1].removingHTMLEntities, for: .normal)
        answer3.setTitle(answers[2].removingHTMLEntities, for: .normal)
        answer4.setTitle(answers[3].removingHTMLEntities, for: .normal)
    }
    
    // Functie houdt de score bij. Checkt of de button die is ingedrukt overeenkomt met het correct antwoord, dan krijgt score + 1 en wordt de volgende vraag aangeroepen.
    @IBAction func correctScore(_ sender: UIButton) {
        if sender.currentTitle == current_Question.correct {
            score += 1
            nextQuestion()
        } else {
            // Als het niet het juiste antwoord is wordt de volgende vraag aangeroepen.
            nextQuestion()
        }
    }
    
    // Segue naar HighScoreTabelViewController.
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "ResultPage" {
            let highScoreViewController = segue.destination
                as! HighScoreTableViewController
            // de score wordt omgezet in een string en vervolgens opgeslagen in de score van highscoreItem.
            highscoreItem.score = String(score)
            highScoreViewController.highscoreItems.append(highscoreItem)
        }
    }
}
