//
//  PLQuestionConverter.swift
//  question_api
//
//  Created by Daniel Apps on 13/09/22.
//

import Foundation
class  PLQuestionConverter {
    static func parsePLQuestion(bLQuestion: BLQuestion)-> PLAnswerQuestion {
        var pLAnswerQuestion = PLAnswerQuestion()
        
        var possibleAnswer : [String] = bLQuestion.incorrectAnswers
        possibleAnswer.append(bLQuestion.correctAnswer)
        
        pLAnswerQuestion.question = bLQuestion.question
        pLAnswerQuestion.possibleAnswers = possibleAnswer
        return pLAnswerQuestion
    }
}
