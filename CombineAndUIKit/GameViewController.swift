//
//  ViewController.swift
//  CombineAndUIKit
//
//  Created by Sajan Shrestha on 9/3/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit
import Combine

class GameViewController: UIViewController {
    
    @IBOutlet weak var userChoiceImage: UIImageView!
    @IBOutlet weak var computerChoiceImage: UIImageView!
    @IBOutlet weak var winnerLabel: UILabel!
    
    var game = Game()
    
    var winnerCancellable: AnyCancellable?
    var userChoiceImageCancellable: AnyCancellable?
    var computerChoiceImageCancellable: AnyCancellable?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpViews()
        
        setUpAllViewsSubscription()
    }
    
    @IBAction func rockButtonPressed(_ sender: UIButton) {
    
        game.startGame(userChoice: .rock)
    }
    
    @IBAction func paperButtonPressed(_ sender: UIButton) {
        
        game.startGame(userChoice: .paper)
        
    }
    
    @IBAction func scissorButtonPressed(_ sender: UIButton) {
        
        game.startGame(userChoice: .scissor)
        
    }
}



extension GameViewController {
    
    private func setUpViews() {
        
        userChoiceImage.layer.borderWidth = 1
        userChoiceImage.layer.borderColor = UIColor.black.cgColor
        
        computerChoiceImage.layer.borderWidth = 1
        computerChoiceImage.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setUpAllViewsSubscription() {
        
        subscribeWinnerLabelToWinnerPublisher()
        
        subscribeUserChoiceImageToUserChoiceImagePublisher()
        
        subscribeComputerChoiceImageToComputerChoiceImagePublisher()
    }
    
    
    private func subscribeWinnerLabelToWinnerPublisher() {
        
        winnerCancellable = game.$winner
            .map { $0 == nil ? "Draw" : $0?.winMessasage }
            .dropFirst()
            .assign(to: \.text, on: winnerLabel)
    }
    
    private func subscribeUserChoiceImageToUserChoiceImagePublisher() {
        
        userChoiceImageCancellable = game.$userChoice
            .map { self.image(for: $0)}
            .assign(to: \.image, on: userChoiceImage)
    }
    
    private func subscribeComputerChoiceImageToComputerChoiceImagePublisher() {
        
        computerChoiceImageCancellable = game.$computerChoice
            .map { self.image(for: $0) }
            .assign(to: \.image, on: computerChoiceImage)
    }
    
    private func image(for choice: Game.Choice?) -> UIImage? {
        
        guard let choice = choice else { return nil }
        switch choice {
        case .paper:
            return UIImage(named: "paper")
        case .rock:
            return UIImage(named: "rock")
        case .scissor:
            return UIImage(named: "scissor")
        }
    }
}
