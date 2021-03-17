//
//  ViewController.swift
//  BullsEye
//
//  Created by Dunja Acimovic on 12.03.2021..
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var targetLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var roundLabel: UILabel!
    private var currentValue: Int = 0
    private var targetValue = 0
    private var score = 0
    private var round = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup slider
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRigthImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRigthImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewGame()
    }

    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            points += difference == 1 ? 50 : 0
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        let message = "You scored \(points) points"
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                self.startNewRound()
            }
        )
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
        
        // crossfade
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}
