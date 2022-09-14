//
//  ViewController.swift
//  QuestionApi
//
//  Created by Daniel Apps on 14/09/22.
//

import UIKit

class MainViewController: UIViewController {
    
    let questionDataService : QuestionsDataService = QuestionsDataService()
    
    var questionsLoaded : [BLQuestion] = []
    var totalQuestionsLoaded : Int = 0
    var isQuestionAvailable : Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func change(_ sender: UIButton) {
        loadQuestions()
        let vc = AnswerSelectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func loadQuestions(){
        questionDataService.getFromApi(url: ConstansURL.getQuestionsURL,type: BLResponse.self ,onComplete:{ response in
            self.questionsLoaded = response.results
            self.totalQuestionsLoaded = self.questionsLoaded.count
        self.isQuestionAvailable =  self.totalQuestionsLoaded > 0
            for question in self.questionsLoaded {
                print(question)
            }
        })
    }

}

