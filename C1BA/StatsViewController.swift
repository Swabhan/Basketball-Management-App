//
//  StatsViewController.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 3/2/22.
//

import UIKit

class StatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

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
    
    var players = ["Swabhan", "Prabhav", "Vince"]
    

    @IBOutlet weak var playerStatsViewController: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        score1Text.text = String(score1)
        score2Text.text = String(score1)
        
        minutesLabel.text = String(minutes)
        secondsLabel.text = String(seconds)
        
        quarterLabel.text = String(quarter)
        
        playerStatsViewController.delegate = self
        playerStatsViewController.dataSource = self

    }
    
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int){
            print("You selected")
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = playerStatsViewController.dequeueReusableCell(withIdentifier: "playerStatCell", for: indexPath)
            cell.textLabel?.text = players[indexPath.row]
            return cell
        }
    

    
    

}
