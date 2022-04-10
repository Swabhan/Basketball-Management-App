//
//  StatsViewController.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 3/2/22.
//

import UIKit

class StatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

    //Scores
    @IBOutlet weak var score1Text: UILabel!
    @IBOutlet weak var score2Text: UILabel!
    
    var score1 = 0
    var score2 = 0
    
    //Time and quarters
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var minutes = 12
    var seconds = 00
    
    var quarter = 1
    @IBOutlet weak var quarterLabel: UILabel!
    
    //Stat Data
    var team1:[String:[Int:[String:Int]]] = [:] 
    var team2:[String:[Int:[String:Int]]] = [:]
    var players : [String] = []
    
    var team1Total:[String:[String:Int]]  = [:]
    var team2Total:[String:[String:Int]]  = [:]
    
    //Table View
    @IBOutlet weak var playerStatsViewController: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gets total stats for game rather than quarter
        gameTotal()
        
        //Adds all players in a list for the tableview to go through
        players = Array(team1.keys)
        players = players + Array(team2.keys)
        
        //Scoreboard
        score1Text.text = String(score1)
        score2Text.text = String(score2)
        
        minutesLabel.text = String(minutes)
        if(seconds < 10){
            secondsLabel.text = "0" + String(seconds)
    } else {
        secondsLabel.text = String(seconds)
    }
        
        quarterLabel.text = String(quarter)
        
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
            
            //Changes text for each stat on each cell
            if(team1[players[indexPath.row]] != nil){
                cell.points.text = String(team1Total[players[indexPath.row]]!["Points"]!)
                cell.assists.text = String(team1Total[players[indexPath.row]]!["Assists"]!)
                cell.rebounds.text = String(team1Total[players[indexPath.row]]!["Rebounds"]!)
                cell.steals.text = String(team1Total[players[indexPath.row]]!["Steals"]!)
                cell.turnovers.text = String(team1Total[players[indexPath.row]]!["Turnovers"]!)
                cell.fgm.text = String(team1Total[players[indexPath.row]]!["FGM"]!)
                cell.fga.text = String(team1Total[players[indexPath.row]]!["FGA"]!)
                cell.threepm.text = String(team1Total[players[indexPath.row]]!["3PM"]!)
                cell.threepa.text = String(team1Total[players[indexPath.row]]!["3PA"]!)
                cell.ftm.text = String(team1Total[players[indexPath.row]]!["FTM"]!)
                cell.fta.text = String(team1Total[players[indexPath.row]]!["FTA"]!)
                cell.name.text = String(players[indexPath.row])
                
            } else {
                cell.points.text = String(team2Total[players[indexPath.row]]!["Points"]!)
                cell.assists.text = String(team2Total[players[indexPath.row]]!["Assists"]!)
                cell.rebounds.text = String(team2Total[players[indexPath.row]]!["Rebounds"]!)
                cell.steals.text = String(team2Total[players[indexPath.row]]!["Steals"]!)
                cell.turnovers.text = String(team2Total[players[indexPath.row]]!["Turnovers"]!)
                cell.fgm.text = String(team2Total[players[indexPath.row]]!["FGM"]!)
                cell.fga.text = String(team2Total[players[indexPath.row]]!["FGA"]!)
                cell.threepm.text = String(team2Total[players[indexPath.row]]!["3PM"]!)
                cell.threepa.text = String(team2Total[players[indexPath.row]]!["3PA"]!)
                cell.ftm.text = String(team2Total[players[indexPath.row]]!["FTM"]!)
                cell.fta.text = String(team2Total[players[indexPath.row]]!["FTA"]!)
                cell.name.text = String(players[indexPath.row])
            }
            
            return cell
        }
    

    func gameTotal(){
        for i in team1.keys{ //Adds to dictionary with player totals
            team1Total[i] = [:]
            team1Total[i]! = ["Points":0, "Assists":0, "Rebounds":0, "Steals": 0, "Turnovers": 0, "FGM": 0, "FGA": 0, "3PM": 0, "3PA": 0, "FTM": 0, "FTA": 0]
        }
        
        for i in team2.keys{ //Adds each player to the game
            team2Total[i] = [:]
            team2Total[i]! = ["Points":0, "Assists":0, "Rebounds":0, "Steals": 0, "Turnovers": 0, "FGM": 0, "FGA": 0, "3PM": 0, "3PA": 0, "FTM": 0, "FTA": 0]
        }
        
        for i in team1.keys{ //Adds up stats for all quarters and adds to team totals
            for quarter in 1...4{
                team1Total[i]!["Points"]! = team1Total[i]!["Points"]! + team1[i]![quarter]!["Points"]!
                team1Total[i]!["Assists"]! = team1Total[i]!["Assists"]! + team1[i]![quarter]!["Assists"]!
                team1Total[i]!["Rebounds"]! = team1Total[i]!["Rebounds"]! + team1[i]![quarter]!["Rebounds"]!
                team1Total[i]!["Steals"]! = team1Total[i]!["Steals"]! + team1[i]![quarter]!["Steals"]!
                team1Total[i]!["Turnovers"]! = team1Total[i]!["Turnovers"]! + team1[i]![quarter]!["Turnovers"]!
                team1Total[i]!["FGM"]! = team1Total[i]!["FGM"]! + team1[i]![quarter]!["FGM"]!
                team1Total[i]!["FGA"]! = team1Total[i]!["FGA"]! + team1[i]![quarter]!["FGA"]!
                team1Total[i]!["3PM"]! = team1Total[i]!["3PM"]! + team1[i]![quarter]!["3PM"]!
                team1Total[i]!["3PA"]! = team1Total[i]!["3PA"]! + team1[i]![quarter]!["3PA"]!
                team1Total[i]!["FTM"]! = team1Total[i]!["FTM"]! + team1[i]![quarter]!["FTM"]!
                team1Total[i]!["FTA"]! = team1Total[i]!["FTA"]! + team1[i]![quarter]!["FTA"]!
            }
        }
        
        for i in team2.keys{
            for quarter in 1...4{
                team2Total[i]!["Points"]! = team2Total[i]!["Points"]! + team2[i]![quarter]!["Points"]!
                team2Total[i]!["Assists"]! = team2Total[i]!["Assists"]! + team2[i]![quarter]!["Assists"]!
                team2Total[i]!["Rebounds"]! = team2Total[i]!["Rebounds"]! + team2[i]![quarter]!["Rebounds"]!
                team2Total[i]!["Steals"]! = team2Total[i]!["Steals"]! + team2[i]![quarter]!["Steals"]!
                team2Total[i]!["Turnovers"]! = team2Total[i]!["Turnovers"]! + team2[i]![quarter]!["Turnovers"]!
                team2Total[i]!["FGM"]! = team2Total[i]!["FGM"]! + team2[i]![quarter]!["FGM"]!
                team2Total[i]!["FGA"]! = team2Total[i]!["FGA"]! + team2[i]![quarter]!["FGA"]!
                team2Total[i]!["3PM"]! = team2Total[i]!["3PM"]! + team2[i]![quarter]!["3PM"]!
                team2Total[i]!["3PA"]! = team2Total[i]!["3PA"]! + team2[i]![quarter]!["3PA"]!
                team2Total[i]!["FTM"]! = team2Total[i]!["FTM"]! + team2[i]![quarter]!["FTM"]!
                team2Total[i]!["FTA"]! = team2Total[i]!["FTA"]! + team2[i]![quarter]!["FTA"]!
            }
        }
    }
}
