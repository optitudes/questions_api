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
    
    var testCountries: [String] = ["Panama","Colombia","Peru","Rusia","Alemania","Brasil","Venezuela","Costa rica","Nort Corea","Japon","Ucrania","as","asdf","asdfasdf","asdfadf","adsfeeee","333"]

    @IBOutlet weak var tableViewQuestions: UITableView!
    let defa: Int = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestions()
        
        tableViewQuestions.dataSource = self
        tableViewQuestions.delegate = self
    }
    
    @IBAction func change(_ sender: UIButton) {
        let vc = AnswerSelectionViewController()
        vc.delegate = self
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
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (testCountries[indexPath.row])
    }
    
}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "firtsCell")
        if (cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell!.textLabel?.text = testCountries[indexPath.row]
        return cell!
    }
    
    
}
extension MainViewController: AnswerSelectionViewControllerDelegate{
        func userDidAnswer(_ question: String) {
            print("conexion entre controladores exitosa")
            print(question)
        }
    }

