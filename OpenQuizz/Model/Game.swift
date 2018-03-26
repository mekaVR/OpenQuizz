//
//  Game.swift
//  OpenQuizz
//
//  Created by meka on 26/03/2018.
//  Copyright © 2018 meka. All rights reserved.
//

import Foundation

class Game {
    var score = 0
    
    private var questions = [Question]()
    private var currentIndex = 0
    
    var state:State = .ongoing
    
    enum State {
        case ongoing, over
    }
    
    var currentQuestion: Question {
        return questions[currentIndex]
    }
    
    func refresh() {
        score = 0
        state = .over
        currentIndex = 0
        
        QuestionManager.shared.get{ (questions) in
            self.questions = questions
            self.state = .ongoing
        }
    }
    
    func answerCurrentQuestion(with answer: Bool){
        if (currentQuestion.isCorrect && answer) || (!currentQuestion.isCorrect && !answer){
            score += 1
        }
        goToNextQuestion()
    }
    
    func goToNextQuestion() {
        if currentIndex < questions.count-1 {
            currentIndex += 1
        } else {
            finishGame()
        }
    }
    
    func finishGame() {
        state = .over
    }
}
