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
    {
        didSet {
            print("##tablesLoaded")
            print("\(Thread.current)")
//            self.tableViewQuestions.reloadData()
        }
    }
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
    
    @IBAction func change(_ sender: UIButton) {
        let vc = AnswerSelectionViewController()
        vc.delegate = self
        
        let pLAnswerQuestion: PLAnswerQuestion = PLAnswerQuestion(question: "la pregunta es dura\n asdf\nasdf",possibleAnswers: ["Esta no es", "por aqui tampoco ", "Esta si es"])
        vc.pLAnswerQuestion = pLAnswerQuestion
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadTables() {
        
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
            
            print("##data seteada \(self.questionsLoaded)")
            
            for question in self.questionsLoaded {
                print(question)
            }
            self.questions.send(true)
//            self.reloadTables()
        })
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("## Se selecciono un objeto \(indexPath.row)")
        print ("##pregunta :\(questionsLoaded[indexPath.row])")
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
        func userDidAnswer(_ question: String) {
            print("conexion entre controladores exitosa")
            print(question)
        }
    }

