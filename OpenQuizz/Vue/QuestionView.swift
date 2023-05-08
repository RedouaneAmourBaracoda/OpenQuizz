//
//  QuestionView.swift
//  OpenQuizz
//
//  Created by Redouane on 07/05/2023.
//

import UIKit

class QuestionView: UIView {
    @IBOutlet private var label: UILabel!
    @IBOutlet private var icon: UIImageView!
    
    enum Style {
        case correct, incorrect, standard
    }
    
    var style: Style = .standard {
        didSet {
            setStyle(style)
        }
    }
    private func setStyle(_ style: Style){
        switch style {
        case .correct:
            self.backgroundColor = .green
            icon.image = UIImage(named: "Icon Correct")
            icon.isHidden = false
        case .incorrect:
            self.backgroundColor = .red
            icon.image = UIImage(named: "Icon Error")
            icon.isHidden = false
        case .standard:
            self.backgroundColor = .gray
            icon.isHidden = true
        }
    }
    var title: String = ""{
        didSet {
            label.text = title
        }
    }
    
    func displayLabel(){
        print(label?.text ?? "nil")
    }
}
