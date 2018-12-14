//
//  MenuController.swift
//  Trivia
//
//  Created by doortje on 10/12/2018.
//  Copyright © 2018 Doortje. All rights reserved.
//

import Foundation
import UIKit

class MenuController {
    
    // MenuController is shared, zodat hij data kan doorgeven aan meerdere view controllers.
    static let shared = MenuController()
    
    // Base URL voor alle requests over de vragen van de quiz.
    let baseURL_questions = URL(string:  "https://opentdb.com/api.php?amount=10&category=12&difficulty=medium&type=multiple")!
    
    // Base URL voor het bijhouden en ophalen van de scores.
    let baseURL_highscore = URL(string: "https://ide50-dne.cs50.io:8080/highscore")!
    
    // Haalt QuestionItems op
    func fetchQuestionItems(completion: @escaping ([QuestionItem]?) -> Void) {
        let task = URLSession.shared.dataTask(with: baseURL_questions) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let questionitems = try? jsonDecoder.decode(QuestionItems.self, from: data) {
                completion(questionitems.results)
            } else {
                completion(nil)
            }
        }
        //Stuurt het request.
        task.resume()
    }
    
    
    // Submit Score
    func submitScore(forHighScore highscore: HighScoreItem, completion:
        @escaping () -> Void) {
        // Default type van GET naar POST.
        var request = URLRequest(url: baseURL_highscore)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "user=\(highscore.user)&score=\(highscore.score)"
        
        // POST data is opgeslagen in de request.
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(String(bytes: data!, encoding: .utf8))
            completion()
        }
        //Stuurt het request.
        task.resume()
    }
    
    // Haalt Highscore op
    func fetchHighscore(completion: @escaping ([HighScoreItem]?) -> Void) {
        let task = URLSession.shared.dataTask(with: baseURL_highscore) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            do {
                if let data = data {
                let highscore_items = try jsonDecoder.decode([HighScoreItem].self, from: data)
                completion(highscore_items)
            } else {
                completion(nil)
            }
            } catch {
                print(error)
            }
        }
        //Stuurt het request.
        task.resume()
    }
    
}
