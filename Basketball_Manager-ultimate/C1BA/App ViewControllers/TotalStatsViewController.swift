//
//  StatsViewController.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 5/12/22.
//

import UIKit

class TotalViewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //Stat Data
    var team1:[String:[String:Int]] = ["Swabhan": ["Points":0, "Assists":0, "Rebounds":0, "Steals": 0, "Turnovers": 0, "FGM": 0, "FGA": 0, "3PM": 0, "3PA": 0, "FTM": 0, "FTA": 0]]
    var team2:[String:[String:Int]] = ["Swabhan": ["Points":0, "Assists":0, "Rebounds":0, "Steals": 0, "Turnovers": 0, "FGM": 0, "FGA": 0, "3PM": 0, "3PA": 0, "FTM": 0, "FTA": 0]]
    var players : [String] = []
    
    var team1Total:[String:[String:Int]]  = [:]
    var team2Total:[String:[String:Int]]  = [:]
    
    //Table View
    @IBOutlet weak var playerStatsViewController: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Table View set up
        playerStatsViewController.delegate = self
        playerStatsViewController.dataSource = self
        
        playerStatsViewController.register(UINib(nibName: "gameStatCell", bundle: nil), forCellReuseIdentifier: "gameStatCell") //Allows custom cells

        }
    
        //Table View Select
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int){
            print("You selected")
        }
        
        //Set number of rows for table view
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return players.count
        }
        
        //Sets values for each row
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gameStatCell", for: indexPath) as! gameStatCell //Sets cell to get properties from gameStatCell Class
            
            return cell
        }
    }


