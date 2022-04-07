//
//  ViewController.swift
//  C1BA
//
//  Created by Swabhan Katkoori and Prabhav Turimella on 2/21/22.
//

import UIKit

class ViewController: UIViewController, rostersRecieve{
    //-Score Variables
    @IBOutlet weak var score1Text: UIButton!
    @IBOutlet weak var score2Text: UIButton!
    
    var score1 = 0
    var score2 = 0
    
    var lastPoints = 0
    
    var lastShot = ""
    var lastTeamScored = ""
    
    //-Timer Variables
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var startingMinutes = 1
    
    var minutes = 1
    var seconds = 00
    
    var timesPressed = 0 //Keeps track of the amount of times timer has been paused/resumed
    
    //-Quarter Variables
    @IBOutlet weak var quarterLabel: UILabel!
    
    var quarter = 1
    
    //-Player Stats
    var roster1: [String] = [] //when player button gets pressed it chooses one of these players
    var roster2: [String] = []
    
    var allPlayers: [String] = []
    
    var team1:[String:[Int:[String:Int]]] = [:] //Dictionary that keeps track of the stats of the current game
    
    var team2:[String:[Int:[String:Int]]] = [:]
    
    var teamChosen = ""
    
    var playerChosen = ""
    
    var miss = false //If a player misses and the next player chosen gets a rebound
    var turnover = false //If turnover is true the next player chosen gets the steal if they are on the other team
    var assist = false //If a player scores and the next player chosen is on the same team an assist gets added
    
    @IBOutlet weak var lastStatText: UILabel!
    
    @IBOutlet weak var turnoverButton: UIButton!

    @IBOutlet weak var reminderText: UILabel!
    
    //player buttons variable
    @IBOutlet weak var playerButton1: UIButton!
    @IBOutlet weak var playerButton2: UIButton!
    @IBOutlet weak var playerButton3: UIButton!
    @IBOutlet weak var playerButton4: UIButton!
    @IBOutlet weak var playerButton5: UIButton!
    @IBOutlet weak var playerButton6: UIButton!
    @IBOutlet weak var playerButton7: UIButton!
    @IBOutlet weak var playerButton8: UIButton!
    @IBOutlet weak var playerButton9: UIButton!
    @IBOutlet weak var playerButton10: UIButton!

    override func viewDidLoad() {//Function runs when app first runs
        super.viewDidLoad()
        allPlayers = roster1 + roster2
        
        //setting the initial text of the score to the value of score1 and score2 in the UI
        score1Text.setTitle(String(score1), for: .normal)
        score2Text.setTitle(String(score2), for: .normal)
        
        //setting the initial text of the time to the value of minutes and seconds
        minutesLabel.text = String(minutes)
        secondsLabel.text = "0" + String(seconds)
        
        //setting the initial text of the quarter
        quarterLabel.text = String(quarter)
        
        //Sets default stats for players
        
        for i in 0...roster1.count - 1{ //Adds each player to the game
            team1[roster1[i]] = [:]
            team2[roster2[i]] = [:]
            
            for x in 1...4{ //Used to create stats per quarter
                team1[roster1[i]]![x] = ["Points":0, "Assists":0, "Rebounds":0, "Steals": 0, "Turnovers": 0, "FGM": 0, "FGA": 0, "3PM": 0, "3PA": 0, "FTM": 0, "FTA": 0]
                
                team2[roster2[i]]![x] = ["Points":0, "Assists":0, "Rebounds":0, "Steals": 0, "Turnovers": 0, "FGM": 0, "FGA": 0, "3PM": 0, "3PA": 0, "FTM": 0, "FTA": 0]
            }

        }
        
        playerButton1.setTitle(allPlayers[0], for: .normal)
        playerButton2.setTitle(allPlayers[1], for: .normal)
        playerButton3.setTitle(allPlayers[2], for: .normal)
        playerButton4.setTitle(allPlayers[3], for: .normal)
        playerButton5.setTitle(allPlayers[4], for: .normal)
        playerButton6.setTitle(allPlayers[5], for: .normal)
        playerButton7.setTitle (allPlayers[6], for: .normal)
        playerButton8.setTitle(allPlayers[7], for: .normal)
        playerButton9.setTitle(allPlayers[8], for: .normal)
        playerButton10.setTitle(allPlayers[9], for: .normal)

    }
    
    //-Time Buttons
    @IBAction func time(_ sender: Any) {
        timesPressed = timesPressed + 1
        turnover = false
        miss = false
        reminderText.text = ""
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            
            if (seconds == 00) { //If seconds is 0, reset to 59 and lower the minute
                //Update timer views
                self.minutesLabel.text = String(minutes)
                self.secondsLabel.text = "0" + String(seconds)
                
                seconds = 59
                self.minutes = minutes - 1
            } else {
                //Update timer views
                self.minutesLabel.text = String(minutes)
                self.secondsLabel.text = String(seconds)
                
                self.seconds = seconds - 1
            }
            
            if (seconds <= 9) { //Formatting for the seconds label
                self.secondsLabel.text = "0" + String(seconds)
            }
            
            
            if (self.timesPressed % 2 == 0) { //If the timesPressed is divisable by 2 then timer is paused
                timer.invalidate()
                turnover = false
                assist = false
                reminderText.text = ""
            }
            
            if (minutes == 0 && seconds == 0){ //Resets time and starts new quarter
                minutes = startingMinutes
                seconds = 0
                
                //Pausing timer and adding quarter
                timer.invalidate()
                self.timesPressed = self.timesPressed + 1
                quarter = quarter + 1
                
                //Resetting Labels
                minutesLabel.text = String(minutes)
                secondsLabel.text = "0" + String(seconds)
            
                quarterLabel.text = String(quarter)
                
                
            }
        }
}
    
    //-Score Buttons
    @IBAction func add3(_ sender: Any) {
        if(miss == false){
            if(teamChosen == "team1"){
                score1 = score1 + 3
                team1[playerChosen]![quarter]!["Points"]! = team1[playerChosen]![quarter]!["Points"]! + 3
                team1[playerChosen]![quarter]!["FGM"]! = team1[playerChosen]![quarter]!["FGM"]! + 1
                team1[playerChosen]![quarter]!["FGA"]! = team1[playerChosen]![quarter]!["FGA"]! + 1
                team1[playerChosen]![quarter]!["3PM"]! = team1[playerChosen]![quarter]!["3PM"]! + 1
                team1[playerChosen]![quarter]!["3PA"]! = team1[playerChosen]![quarter]!["3PA"]! + 1
                print(team1[playerChosen]![quarter]!)
               
            } else {
                score2 = score2 + 3
                team2[playerChosen]![quarter]!["Points"]! = team2[playerChosen]![quarter]!["Points"]! + 3
                team2[playerChosen]![quarter]!["FGM"]! = team2[playerChosen]![quarter]!["FGM"]! + 1
                team2[playerChosen]![quarter]!["FGA"]! = team2[playerChosen]![quarter]!["FGA"]! + 1
                team2[playerChosen]![quarter]!["3PM"]! = team2[playerChosen]![quarter]!["3PM"]! + 1
                team2[playerChosen]![quarter]!["3PA"]! = team2[playerChosen]![quarter]!["3PA"]! + 1
                print(team2[playerChosen]![quarter]!)
            }
            updateScore()
            lastPoints = 3
            lastShot = "3p"
            lastStatText.text = playerChosen + " made a 3!"
            reminderText.text = "Assist?"
            assist = true
            lastTeamScored = teamChosen
        } else {
            lastPoints = 3
            lastShot = "3p"
            missedShot()
        }
        
    }
    
    @IBAction func add2(_ sender: Any) {
        if(miss == false){
            if(teamChosen == "team1"){
                score1 = score1 + 2
                team1[playerChosen]![quarter]!["Points"]! = team1[playerChosen]![quarter]!["Points"]! + 2
                team1[playerChosen]![quarter]!["FGM"]! = team1[playerChosen]![quarter]!["FGM"]! + 1
                team1[playerChosen]![quarter]!["FGA"]! = team1[playerChosen]![quarter]!["FGA"]! + 1
                print(team1[playerChosen]![quarter]!)
            } else {
                score2 = score2 + 2
                team2[playerChosen]![quarter]!["Points"]! = team2[playerChosen]![quarter]!["Points"]! + 2
                team2[playerChosen]![quarter]!["FGM"]! = team2[playerChosen]![quarter]!["FGM"]! + 1
                team2[playerChosen]![quarter]!["FGA"]! = team2[playerChosen]![quarter]!["FGA"]! + 1
                print(team2[playerChosen]![quarter]!)
                
            }
            updateScore()
            lastPoints = 2
            lastShot = "2p"
            lastStatText.text = playerChosen + " made a 2!"
            reminderText.text = "Assist?"
            assist = true
            lastTeamScored = teamChosen
        } else {
            lastPoints = 2
            lastShot = "2p"
            missedShot()

        }
    }
    
    
    @IBAction func add1(_ sender: Any) {
        if(miss == false){
            if(teamChosen == "team1"){
                score1 = score1 + 1
                team1[playerChosen]![quarter]!["Points"]! = team1[playerChosen]![quarter]!["Points"]! + 1
                team1[playerChosen]![quarter]!["FTM"]! = team1[playerChosen]![quarter]!["FTM"]! + 1
                team1[playerChosen]![quarter]!["FTA"]! = team1[playerChosen]![quarter]!["FTA"]! + 1
                print(team1[playerChosen]![quarter]!)
            } else {
                score2 = score2 + 1
                team2[playerChosen]![quarter]!["Points"]! = team2[playerChosen]![quarter]!["Points"]! + 1
                team2[playerChosen]![quarter]!["FTM"]! = team2[playerChosen]![quarter]!["FTM"]! + 1
                team2[playerChosen]![quarter]!["FTA"]! = team2[playerChosen]![quarter]!["FTA"]! + 1
                print(team2[playerChosen]![quarter]!)
            }
            updateScore()
            lastPoints = 1
            lastShot = "1p"
            lastStatText.text = playerChosen + " made a free throw!"
        } else {
            lastPoints = 1
            lastShot = "1p"
            missedShot()
            miss = false
        }
    }
    
    func rebounds(){
        addAssistReboundStealTurnover(Stat : "Rebounds")
        lastStatText.text = playerChosen + " got a rebound!"
    }
    
    func steals(){
        addAssistReboundStealTurnover(Stat : "Steals")
        lastStatText.text = playerChosen + " got a steal!"
    }
    
    @IBAction func addAssist(_ sender: Any) {
        addAssistReboundStealTurnover(Stat : "Assists")
        lastStatText.text = playerChosen + " got a assist!"
    }
    
    @IBAction func addTurnover(_ sender: Any) {
        addAssistReboundStealTurnover(Stat : "Turnovers")
        turnover = true
        lastStatText.text = playerChosen + " got a turnover"
        reminderText.text = "Who got a steal?"
    }
    
    @IBAction func missButton(_ sender: Any) {
        miss = true
    }
    
    func missedShot(){
        if(teamChosen == "team1"){
            if(lastShot == "3p"){
                team1[playerChosen]![quarter]!["FGA"]! = team1[playerChosen]![quarter]!["FGA"]! + 1
                team1[playerChosen]![quarter]!["3PA"]! = team1[playerChosen]![quarter]!["3PA"]! + 1
                lastStatText.text = playerChosen + " missed a 3"
            } else if(lastShot == "2p"){
                team1[playerChosen]![quarter]!["FGA"]! = team1[playerChosen]![quarter]!["FGA"]! + 1
                lastStatText.text = playerChosen + " missed a 2"
            } else if(lastShot == "1p"){
                team1[playerChosen]![quarter]!["FTA"]! = team1[playerChosen]![quarter]!["FTA"]! + 1
                lastStatText.text = playerChosen + " missed a free throw"
            }
            print(team1[playerChosen]![quarter]!)
        } else {
            if(lastShot == "3p"){
                team2[playerChosen]![quarter]!["FGA"]! = team2[playerChosen]![quarter]!["FGA"]! + 1
                team2[playerChosen]![quarter]!["3PA"]! = team2[playerChosen]![quarter]!["3PA"]! + 1
                lastStatText.text = playerChosen + " missed a 3"
            } else if(lastShot == "2p"){
                team2[playerChosen]![quarter]!["FGA"]! = team2[playerChosen]![quarter]!["FGA"]! + 1
                lastStatText.text = playerChosen + " missed a 2"
            } else if(lastShot == "1p"){
                team2[playerChosen]![quarter]!["FTA"]! = team2[playerChosen]![quarter]!["FTA"]! + 1
                lastStatText.text = playerChosen + " missed a free throw"
            }
            print(team2[playerChosen]![quarter]!)
        }
        reminderText.text = "Who got the rebound"
        
    }
    
    //Subtracts team score if the score button has been pressed
    @IBAction func subtractTeam1(_ sender: Any) {
        score1 = score1 - lastPoints
        if(lastShot == "3p"){
            team1[playerChosen]![quarter]!["Points"]! = team1[playerChosen]![quarter]!["Points"]! - 3
            team1[playerChosen]![quarter]!["FGM"]! = team1[playerChosen]![quarter]!["FGM"]! - 1
            team1[playerChosen]![quarter]!["FGA"]! = team1[playerChosen]![quarter]!["FGA"]! - 1
            team1[playerChosen]![quarter]!["3PM"]! = team1[playerChosen]![quarter]!["3PM"]! - 1
            team1[playerChosen]![quarter]!["3PA"]! = team1[playerChosen]![quarter]!["3PA"]! - 1
        } else if(lastShot == "2p"){
            team1[playerChosen]![quarter]!["Points"]! = team1[playerChosen]![quarter]!["Points"]! - 2
            team1[playerChosen]![quarter]!["FGM"]! = team1[playerChosen]![quarter]!["FGM"]! - 1
            team1[playerChosen]![quarter]!["FGA"]! = team1[playerChosen]![quarter]!["FGA"]! - 1
        } else {
            team1[playerChosen]![quarter]!["Points"]! = team1[playerChosen]![quarter]!["Points"]! - 1
            team1[playerChosen]![quarter]!["FGM"]! = team1[playerChosen]![quarter]!["FGM"]! - 1
            team1[playerChosen]![quarter]!["FGA"]! = team1[playerChosen]![quarter]!["FGA"]! - 1
            team1[playerChosen]![quarter]!["FTM"]! = team1[playerChosen]![quarter]!["FTM"]! - 1
            team1[playerChosen]![quarter]!["FTA"]! = team1[playerChosen]![quarter]!["FTA"]! - 1
        }
        updateScore()
    }
    
    @IBAction func subtractTeam2(_ sender: Any) {
        score2 = score2 - lastPoints
        if(lastShot == "3p"){
            team2[playerChosen]![quarter]!["Points"]! = team2[playerChosen]![quarter]!["Points"]! - 3
            team2[playerChosen]![quarter]!["FGM"]! = team2[playerChosen]![quarter]!["FGM"]! - 1
            team2[playerChosen]![quarter]!["FGA"]! = team2[playerChosen]![quarter]!["FGA"]! - 1
            team2[playerChosen]![quarter]!["3PM"]! = team2[playerChosen]![quarter]!["3PM"]! - 1
            team2[playerChosen]![quarter]!["3PA"]! = team2[playerChosen]![quarter]!["3PA"]! - 1
        } else if(lastShot == "2p"){
            team2[playerChosen]![quarter]!["Points"]! = team2[playerChosen]![quarter]!["Points"]! - 2
            team2[playerChosen]![quarter]!["FGM"]! = team2[playerChosen]![quarter]!["FGM"]! - 1
            team2[playerChosen]![quarter]!["FGA"]! = team2[playerChosen]![quarter]!["FGA"]! - 1
        } else {
            team2[playerChosen]![quarter]!["Points"]! = team2[playerChosen]![quarter]!["Points"]! - 1
            team2[playerChosen]![quarter]!["FGM"]! = team2[playerChosen]![quarter]!["FGM"]! - 1
            team2[playerChosen]![quarter]!["FGA"]! = team2[playerChosen]![quarter]!["FGA"]! - 1
            team2[playerChosen]![quarter]!["FTM"]! = team2[playerChosen]![quarter]!["FTM"]! - 1
            team2[playerChosen]![quarter]!["FTA"]! = team2[playerChosen]![quarter]!["FTA"]! - 1
        }
        updateScore()
    }
    
    
    //-Choose Player
    @IBAction func playerButton(_ sender: UIButton) {
        if(sender.tag <= 5){
            teamChosen = "team1"
            playerChosen = roster1[sender.tag - 1]
        } else {
            teamChosen = "team2"
            playerChosen = roster2[sender.tag - 6]
        }
        lastStatText.text = playerChosen
        
        //Rebound
        if(miss == true){
            if(sender.tag <= 5){
                teamChosen = "team1"
                playerChosen = roster1[sender.tag - 1]
            } else {
                teamChosen = "team2"
                playerChosen = roster2[sender.tag - 6]
            }
            lastStatText.text = playerChosen
            rebounds()
            miss = false
            reminderText.text = ""
        }
        
        //Assist
        if(assist == true){
            if(teamChosen == lastTeamScored){
                if(sender.tag <= 5){
                    teamChosen = "team1"
                    playerChosen = roster1[sender.tag - 1]
                } else {
                    teamChosen = "team2"
                    playerChosen = roster2[sender.tag - 6]
                }
                lastStatText.text = playerChosen
                addAssist(playerChosen)
                assist = false
            }
            reminderText.text = ""
        }
        
        //Steal
        if(turnover){
            if(sender.tag <= 5){
                teamChosen = "team1"
                playerChosen = roster1[sender.tag - 1]
            } else {
                teamChosen = "team2"
                playerChosen = roster2[sender.tag - 6]
            }
            lastStatText.text = playerChosen
            steals()
            turnover = false
            reminderText.text = ""
        }
    }
    
    //Changes score text
    func updateScore(){
        score1Text.setTitle(String(score1), for: .normal)
        score2Text.setTitle(String(score2), for: .normal)
    }
    
    //Clean code functions
    func addAssistReboundStealTurnover(Stat : String){
        if(teamChosen == "team1"){
            team1[playerChosen]![quarter]![Stat]! = team1[playerChosen]![quarter]![Stat]! + 1
        } else {
            team2[playerChosen]![quarter]![Stat]! = team2[playerChosen]![quarter]![Stat]! + 1
        }
    }
    
    //Stats Segue
    @IBAction func goToStats(_ sender: Any) {
        performSegue(withIdentifier: "statSegue", sender: (Any).self)
    }
    
    //Substitutions
    func dataRecieved(team1List: [String], team2List: [String]) { //gets data from chooseRosters view controller through a protocol
        //Adds player to lineup
        roster1 = team1List
        roster2 = team2List
        allPlayers = roster1 + roster2
        
        //Adds substitution to stat sheet
        for i in roster1{
            if(team1[i] == nil){
                team1[i] = [:]
                for x in 1...4{ //Used to create stats per quarter
                    team1[i]![x] = ["Points":0, "Assists":0, "Rebounds":0, "Steals": 0, "Turnovers": 0, "FGM": 0, "FGA": 0, "3PM": 0, "3PA": 0, "FTM": 0, "FTA": 0]
                }
            }
        }
        
        for i in roster2{
            if(team2[i] == nil){
                team2[i] = [:]
                for x in 1...4{ //Used to create stats per quarter
                    team2[i]![x] = ["Points":0, "Assists":0, "Rebounds":0, "Steals": 0, "Turnovers": 0, "FGM": 0, "FGA": 0, "3PM": 0, "3PA": 0, "FTM": 0, "FTA": 0]
                }
            }
        }
        
        //Changes the title on the button to match the current lineup
        playerButton1.setTitle(allPlayers[0], for: .normal)
        playerButton2.setTitle(allPlayers[1], for: .normal)
        playerButton3.setTitle(allPlayers[2], for: .normal)
        playerButton4.setTitle(allPlayers[3], for: .normal)
        playerButton5.setTitle(allPlayers[4], for: .normal)
        playerButton6.setTitle(allPlayers[5], for: .normal)
        playerButton7.setTitle (allPlayers[6], for: .normal)
        playerButton8.setTitle(allPlayers[7], for: .normal)
        playerButton9.setTitle(allPlayers[8], for: .normal)
        playerButton10.setTitle(allPlayers[9], for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "statSegue"{
            let destinationVC = segue.destination as! StatsViewController
            
            destinationVC.score1 = score1
            destinationVC.score2 = score2
            
            destinationVC.minutes = minutes
            destinationVC.seconds = seconds
            destinationVC.quarter = quarter
            
            destinationVC.team1 = team1
            destinationVC.team2 = team2
            
            
        }
        
        if segue.identifier == "subs"{
            let destinationVC = segue.destination as! ChooseRosters
            
            destinationVC.team1 = roster1
            destinationVC.team2 = roster2
            
            destinationVC.delegate = self
            
            destinationVC.modalPresentationStyle = .fullScreen
        }
    }
    
}
