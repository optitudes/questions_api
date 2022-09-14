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
    var levelsRegistereds : Int = 0
    var currentLevel :  Int = 0
    @IBOutlet weak var tableViewQuestions: UITableView!
    let defa: Int = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewQuestions.dataSource = self
        tableViewQuestions.delegate = self
        loadQuestions()
        registerTableViewRows()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func change(_ sender: UIButton) {
        let vc = AnswerSelectionViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func reload(_ sender: UIButton) {
        tableViewQuestions.reloadData()

        
    }
    func registerTableViewRows() {
        let nibName = UINib(nibName: "\(QuestionTableViewCell.self)", bundle: nil)
        tableViewQuestions.register(nibName, forCellReuseIdentifier: "\(QuestionTableViewCell.self)")
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
        print (questionsLoaded[indexPath.row])
    }
    
}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        ttextViewCategory.backgroundColor = UIColor.lightGray
        return questionsLoaded.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(QuestionTableViewCell.self)") as? QuestionTableViewCell else {
            return UITableViewCell()
        }
        cell.textViewCategory.text = questionsLoaded[indexPath.row].category
        cell.labelLevelValue.text = String(indexPath.row + 1)
        cell.backgroundColor = UIColor.gray
        return cell
    }
    
    
}
extension MainViewController: AnswerSelectionViewControllerDelegate{
        func userDidAnswer(_ question: String) {
            print("conexion entre controladores exitosa")
            print(question)
        }
    }

