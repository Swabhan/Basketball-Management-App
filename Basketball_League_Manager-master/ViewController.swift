//
//  ViewController.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 2/21/22.
//

import UIKit

class ViewController: UIViewController {
    //-Score Variables
    @IBOutlet weak var score1Text: UIButton!
    @IBOutlet weak var score2Text: UIButton!
    
    var score1 = 0
    var score2 = 0
    
    //-Time Variables
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var minutes = 12
    var seconds = 00
    
    override func viewDidLoad() {//Function runs when app first runs
        super.viewDidLoad()
        
        //setting the initial text of the score to the value of score1 and score2 in the UI
        score1Text.setTitle(String(score1), for: .normal)
        score2Text.setTitle(String(score2), for: .normal)
        
        //setting the initial text of the time to the value of minutes and seconds
        minutesLabel.text = String(minutes)
        secondsLabel.text = "0" + String(seconds)
    }
    
    //-Time Buttons
    @IBAction func time(_ sender: Any) {
        print("Time")
    }
    
    //-Score Update Buttons
    @IBAction func add3(_ sender: Any) {
        print("Adding 3")
    }
    
    @IBAction func add2(_ sender: Any) {
        print("Adding 2")
    }
    
    @IBAction func add1(_ sender: Any) {
        print("Adding 1")
    }
    
    

}

