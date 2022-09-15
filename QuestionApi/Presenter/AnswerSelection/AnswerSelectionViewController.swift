//
//  AnswerSelectionViewController.swift
//  QuestionApi
//
//  Created by Daniel Apps on 14/09/22.
//

import UIKit

class AnswerSelectionViewController: UIViewController {
    
    weak var delegate: AnswerSelectionViewControllerDelegate?
    var pLAnswerQuestion: PLAnswerQuestion = PLAnswerQuestion()
    var answerList : [String] = []
    var answerSelected : String = ""
//    @IBOutlet weak var pickerViewAnswer: UIPickerView!
    @IBOutlet weak var textQuestion: UITextView!
    
    @IBOutlet weak var pickerPossibleAnswer: UIPickerView!
    
//    @IBOutlet weak var stackViewPossibleAnswers: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textQuestion.text = pLAnswerQuestion.question
        answerList = pLAnswerQuestion.possibleAnswers
        print("###pregunta cargada \(textQuestion.text)")
        print(pLAnswerQuestion.possibleAnswers)
        
        pickerPossibleAnswer.dataSource = self
        pickerPossibleAnswer.delegate = self
        
//        stackViewPossibleAnswers.translatesAutoresizingMaskIntoConstraints = false
//
//        test.forEach{ answer in
//            let possibleAnswerView: PossibleAnswerView = PossibleAnswerView.fromNib()
//            possibleAnswerView.setAnswer(answer: answer)
//            possibleAnswerView.translatesAutoresizingMaskIntoConstraints = false
//            possibleAnswerView.addArrangedSubview(possibleAnswerView)
//        }
//
        
//        let answerList : [UIView] = getAnswerList(answerList: pLAnswerQuestion.possibleAnswers)
        
            
//        pickerViewAnswer.dataSource = self
//        pickerViewAnswer.delegate = self

    }

    @IBAction func userdidConfirmAnswer(_ sender: UIButton) {
        let isValidAnswer : Bool = !answerSelected.isEmpty
        print("is valid ? \(isValidAnswer)")
        if(isValidAnswer){
            delegate?.userDidAnswer(answerSelected)
            self.navigationController?.popViewController(animated: true)

        }
    }
}
//func getAnswerList(answerList: [String])-> [UIView] {
//    var UIAnswerList : [UIView] = []
//    for i in answerList {
//        var answerView: UIView = PossibleAnswerView.fromNib()
//        answerView.setAnswer(answer: answerList[i])
//        answerView.frame = CGRect(x: 50, y: 50, width: 300, height: 50)
//        answerView.backgroundColor = UIColor.red
//        UIAnswerList.append(answerView)
//    }
//    return UIAnswerList
//
//}
protocol AnswerSelectionViewControllerDelegate: AnyObject{
    func userDidAnswer(_ question: String)
}
extension AnswerSelectionViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answerList.count
    }
    
    
}


extension AnswerSelectionViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return answerList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.answerSelected = answerList[row]
        print("### opcion seleccionada \(self.answerSelected)")
    }
    
}






//extension AnswerSelectionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return Constans.numberOfComponentsOFAnswer
//
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return test.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        print("###opcion \(test[row])")
//        return test[row]
//    }

//}
