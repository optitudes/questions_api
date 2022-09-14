//
//  QuestionTableViewCell.swift
//  QuestionApi
//
//  Created by Daniel Apps on 14/09/22.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textViewCategory: UITextView!
    @IBOutlet weak var labelLevelValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
