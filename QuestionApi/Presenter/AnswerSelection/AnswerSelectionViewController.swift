//
//  AnswerSelectionViewController.swift
//  QuestionApi
//
//  Created by Daniel Apps on 14/09/22.
//

import UIKit

class AnswerSelectionViewController: UIViewController {
    
    weak var delegate: AnswerSelectionViewControllerDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func userdidConfirmAnswer(_ sender: UIButton) {
        delegate?.userDidAnswer("buenas ")
        self.navigationController?.popViewController(animated: true)
    }
}
protocol AnswerSelectionViewControllerDelegate: AnyObject{
    func userDidAnswer(_ question: String)
}
