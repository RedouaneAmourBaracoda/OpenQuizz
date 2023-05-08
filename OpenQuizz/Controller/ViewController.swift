//
//  ViewController.swift
//  OpenQuizz
//
//  Created by Redouane on 07/05/2023.
//

import UIKit

class ViewController: UIViewController {
    var game = Game()
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let name = Notification.Name("QuestionLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(questionsLoaded), name: name, object: nil)
        startNewGame()
    }
    
    @IBAction func didTapNewGameButton(_ sender: UIButton) {
        startNewGame()
    }
    
    @IBAction func falseTapped(_ sender: UIButton) {
        questionView.style = .incorrect
    }
    
    @IBAction func trueTapped(_ sender: UIButton) {
        questionView.style = .correct
    }

    @IBAction func sendTapped(_ sender: UIButton) {
        answerQuestion()
    }
    
    @objc func questionsLoaded() {
        activityIndicator.isHidden = true
        newGameButton.isHidden = false
        questionView.title = game.currentQuestion.title
    }
    
    private func answerQuestion(){
        if game.state == .ongoing {
            switch questionView.style {
            case .correct:
                game.answerCurrentQuestion(with: true)
            case .incorrect:
                game.answerCurrentQuestion(with: false)
            case .standard:
                break
            }
            
            scoreLabel.text = "\(game.score) / 10"
            questionView.style = .standard
            questionView.title = game.currentQuestion.title
        } else {
            questionView.style = .standard
            questionView.title = "GAME OVER."
        }
    }
    private func startNewGame(){
        activityIndicator.isHidden = false
        newGameButton.isHidden = true
        questionView.title = "Loading..."
        questionView.style = .standard
        scoreLabel.text = "0 / 10"
        game.refresh()
    }
}

