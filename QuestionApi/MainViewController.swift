//
//  ViewController.swift
//  QuestionApi
//
//  Created by Daniel Apps on 14/09/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    var questions = PassthroughSubject<Bool, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    let questionDataService : QuestionsDataService = QuestionsDataService()
    var questionsLoaded : [BLQuestion] = []
    var userScore : Int = 0
    var currentLevel : Int = 0
    var currentLevelIndexPath :  IndexPath?
    var correctAnswer : String = ""
    
    var isGameActive : Bool = true
    
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var tableViewQuestions: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewQuestions.dataSource = self
        tableViewQuestions.delegate = self
        
        registerTableViewRows()
        bind()
        loadQuestions()
        
        print("##Inico carga de preguntas")
    }

    func bind() {
        self.questions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] called in
                guard let self = self else {
                    return
                }
//                    print("## This function work correctly with value \(called)")
                self.tableViewQuestions.reloadData()
            }
            .store(in: &subscriptions)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
  
    func registerTableViewRows() {
        let nibName = UINib(nibName: "\(QuestionTableViewCell.self)", bundle: nil)
        tableViewQuestions.register(nibName, forCellReuseIdentifier: "\(QuestionTableViewCell.self)")
    }
    
    @IBAction func exitProgram(_ sender: UIButton) {
        print("### try it later...")
    }
    @IBAction func startGame(_ sender: UIButton) {
        loadQuestions()
        isGameActive = true
        userScore = 0
        labelScore.text = "0"
        currentLevel = 0
    }
    func loadQuestions(){
        questionDataService.getFromApi(url: ConstansURL.getQuestionsURL,type: BLResponse.self ,onComplete:{ response in
            self.questionsLoaded = response.results
            self.questions.send(true)
//            self.reloadTables()
        })
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isGameActive){
            if( indexPath.row == currentLevel){
                print("## Se selecciono un objeto \(indexPath.row)")
                print ("##pregunta :\(questionsLoaded[indexPath.row])")
                print ("##respuesta :\(questionsLoaded[indexPath.row].correctAnswer)")
                
                self.correctAnswer = questionsLoaded[indexPath.row].correctAnswer
                currentLevelIndexPath = indexPath
                let vc = AnswerSelectionViewController()
                vc.delegate = self
                vc.pLAnswerQuestion = PLQuestionConverter.parsePLQuestion(bLQuestion: questionsLoaded[indexPath.row])
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else {
            print("Please click on start button")
        }
    }
}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        ttextViewCategory.backgroundColor = UIColor.lightGray
        print("### cargaron \(questionsLoaded.count) preguntas")
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
        func userDidAnswer(_ userAnswer: String) {
            print("conexion entre controladores exitosa")
            print("respuesta seleccionada\(userAnswer)")
            print("respuesta correcta \(self.correctAnswer)")
            if(userAnswer.elementsEqual(self.correctAnswer)){
                self.tableViewQuestions.cellForRow(at: tableViewQuestions.indexPathForSelectedRow!)?.backgroundColor = UIColor.green
                    userScore += 200
                    currentLevel += 1
                    labelScore.text = String(userScore)
            }else{
                self.tableViewQuestions.cellForRow(at: tableViewQuestions.indexPathForSelectedRow!)?.backgroundColor = UIColor.red
                isGameActive = false
            }
        }
    }

