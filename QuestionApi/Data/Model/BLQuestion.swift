//
//  BLQuestion.swift
//  question_api
//
//  Created by Daniel Apps on 12/09/22.
//

import Foundation
struct BLResponse: Codable {
    var results : [BLQuestion] =  []
}
struct BLQuestion : Codable{
    var category : String = ""
    var type : String = ""
    var difficulty : String = ""
    var question : String = ""
    var correctAnswer : String = ""
    var incorrectAnswers : [String] = []
    
    enum CodingKeys : String, CodingKey {
        case category = "category"
        case type = "type"
        case difficulty = "difficulty"
        case question = "question"
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
