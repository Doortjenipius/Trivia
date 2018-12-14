//
//  QuestionItem.swift
//  Trivia
//
//  Created by doortje on 10/12/2018.
//  Copyright © 2018 Doortje. All rights reserved.
//

import Foundation

// Struct van alle 'keys' uit de dict in het JSON file.

struct QuestionItem: Codable {
    var category: String
    var type: String
    var difficulty: String
    var correct: String
    var question: String
    var incorrect: [String]
    // Maakt een lijst van correct en incorrect answers bij elkaar.
    var answers: [String] {
        var answers = incorrect
        answers.append(correct)
        return answers.shuffled()
    }
    
    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case correct = "correct_answer"
        case incorrect = "incorrect_answers"
        //  case answers
    }
}

struct QuestionItems: Codable {
    // Alle vragen in het JSON file
    let results: [QuestionItem]
}

