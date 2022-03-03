//
//  StatsViewController.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 3/2/22.
//

import UIKit

class StatsViewController: UIViewController {
    
    
    @IBOutlet weak var score1Text: UILabel!
    @IBOutlet weak var score2Text: UILabel!
    
    var score1 = 0
    var score2 = 0
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var minutes = 12
    var seconds = 00
    
    var quarter = 1
    
    @IBOutlet weak var quarterLabel: UILabel!
    
    
    var team1:[String:[Int:[String:Int]]] = [:] 
    var team2:[String:[Int:[String:Int]]] = [:]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        score1Text.text = String(score1)
        score2Text.text = String(score1)
        
        minutesLabel.text = String(minutes)
        secondsLabel.text = String(seconds)
        
        quarterLabel.text = String(quarter)
        
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
