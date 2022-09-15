//
//  PossibleAnswerView.swift
//  QuestionApi
//
//  Created by Daniel Apps on 15/09/22.
//

import UIKit

class PossibleAnswerView: UIView {
    @IBOutlet weak var answerText: UILabel!
    
    func setAnswer(answer: String) {
        answerText.text = answer
    }

}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
