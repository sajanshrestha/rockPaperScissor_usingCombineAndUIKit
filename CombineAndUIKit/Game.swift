//
//  Game.swift
//  CombineAndUIKit
//
//  Created by Sajan Shrestha on 9/4/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit


class Game {
    
    enum Player: String {
        case computer = "Computer"
        case user = "You"
        
        var winMessasage: String {
            if self == .computer {
                return "Computer has won."
            }
            else {
                return "You have won."
            }
        }
    }
    
    enum Choice: String, CaseIterable {
        case rock, paper, scissor
        
        var image: UIImage? {
            switch self {
            case .rock: return UIImage(named: "rock")
            case .paper: return UIImage(named: "paper")
            case .scissor: return UIImage(named: "scissor")

            }
        }
    }
    
    @Published private(set) var winner: Player?
    @Published private(set) var userChoice: Choice?
    @Published private(set) var computerChoice: Choice?
    
    
    func startGame(userChoice: Game.Choice) {
                
        let computerChoice = Choice.allCases.randomElement()!
        
        setChoices(userChoice, computerChoice)

        setWinner(userChoice, computerChoice)
    }
    
    private func setWinner(_ userChoice: Choice, _ computerChoice: Choice) {
        
        guard computerChoice != userChoice else {
            winner = nil
            return
        }
        
        if userChoice == .rock {
            
            winner = computerChoice == Choice.paper ? .computer : .user
        }
            
        else if userChoice == .paper {
            
            winner = computerChoice == Choice.scissor ? .computer : .user
        }
            
        else {
            
            winner = computerChoice == Choice.rock ? .computer : .user
        }
    }
    
    private func setChoices(_ userChoice: Choice, _ computerChoice: Choice) {
        self.userChoice = userChoice
        self.computerChoice = computerChoice
    }
}
