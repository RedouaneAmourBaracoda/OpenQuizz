//
//  Game.swift
//  OpenQuizz
//
//  Created by Redouane on 07/05/2023.
//

import Foundation

class Game {
    var score = 0

    var questions = [Question]()
    private var currentIndex = 0

    var state: State = .ongoing

    enum State {
        case ongoing, over
    }

    var currentQuestion: Question {
        return questions[currentIndex]
    }

    func refresh() {
        score = 0
        currentIndex = 0
        state = .over
        QuestionManager.shared.get(completionHandler: receiveQuestions(_:))
    }
    
    private func receiveQuestions(_ questions: [Question]){
        self.questions = questions
        state = .ongoing
        let name = Notification.Name("QuestionLoaded")
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }

    func answerCurrentQuestion(with answer: Bool) {
        if (currentQuestion.isCorrect && answer) || (!currentQuestion.isCorrect && !answer) {
            score += 1
        }
        goToNextQuestion()
    }

    private func goToNextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        } else {
            finishGame()
        }
    }

    private func finishGame() {
        state = .over
    }
}
