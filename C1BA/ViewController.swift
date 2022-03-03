//
//  ViewController.swift
//  C1BA
//
//  Created by Swabhan Katkoori and Prabhav Turimella on 2/21/22.
//

import UIKit

class ViewController: UIViewController {
    //-Score Variables
    @IBOutlet weak var score1Text: UIButton!
    @IBOutlet weak var score2Text: UIButton!
    
    var score1 = 0
    var score2 = 0
    
    var lastPoints = 0
    
    var lastShot = ""
    
    //-Timer Variables
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var startingMinutes = 12
    
    var minutes = 12
    var seconds = 00
    
    var timesPressed = 0 //Keeps track of the amount of times timer has been paused/resumed
    
    //-Quarter Variables
    @IBOutlet weak var quarterLabel: UILabel!
    
    var quarter = 1
    
    //-Player Stats
    var roster1 = ["Swabhan", "Prabhav", "Vince", "Anthony", "Zeke"] //when player button gets pressed it chooses one of these players
    var roster2 = ["Sumant", "Sid", "Chris", "Ian", "Aryan"]
    
    var team1:[String:[Int:[String:Int]]] = [:] //Dictionary that keeps track of the stats of the current game
    
    var team2:[String:[Int:[String:Int]]] = [:]
    
    var teamChosen = ""
    
    var playerChosen = ""
    
    var miss = false
    
    
    override func viewDidLoad() {//Function runs when app first runs
        super.viewDidLoad()
        
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

    }
    
    //-Time Buttons
    @IBAction func time(_ sender: Any) {
        timesPressed = timesPressed + 1
        
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
            
            if (seconds <= 10) { //Formatting for the seconds label
                self.secondsLabel.text = "0" + String(seconds)
            }
            
            
            if (self.timesPressed % 2 == 0) { //If the timesPressed is divisable by 2 then timer is paused
                timer.invalidate()
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
               
            } else {
                score2 = score2 + 3
                team2[playerChosen]![quarter]!["Points"]! = team2[playerChosen]![quarter]!["Points"]! + 3
                team2[playerChosen]![quarter]!["FGM"]! = team2[playerChosen]![quarter]!["FGM"]! + 1
                team2[playerChosen]![quarter]!["FGA"]! = team2[playerChosen]![quarter]!["FGA"]! + 1
                team2[playerChosen]![quarter]!["3PM"]! = team2[playerChosen]![quarter]!["3PM"]! + 1
                team2[playerChosen]![quarter]!["3PA"]! = team2[playerChosen]![quarter]!["3PA"]! + 1
                
            }
            updateScore()
            lastPoints = 3
            lastShot = "3p"
        } else {
            lastPoints = 3
            lastShot = "3p"
            missedShot()
            miss = false
        }
        

    }
    
    @IBAction func add2(_ sender: Any) {
        if(miss == false){
            if(teamChosen == "team1"){
                score1 = score1 + 2
                team1[playerChosen]![quarter]!["Points"]! = team1[playerChosen]![quarter]!["Points"]! + 2
                team1[playerChosen]![quarter]!["FGM"]! = team1[playerChosen]![quarter]!["FGM"]! + 1
                team1[playerChosen]![quarter]!["FGA"]! = team1[playerChosen]![quarter]!["FGA"]! + 1

            } else {
                score2 = score2 + 2
                team2[playerChosen]![quarter]!["Points"]! = team2[playerChosen]![quarter]!["Points"]! + 2
                team2[playerChosen]![quarter]!["FGM"]! = team2[playerChosen]![quarter]!["FGM"]! + 1
                team2[playerChosen]![quarter]!["FGA"]! = team2[playerChosen]![quarter]!["FGA"]! + 1
   
                
            }
            updateScore()
            lastPoints = 2
            lastShot = "2p"
        } else {
            lastPoints = 2
            lastShot = "2p"
            missedShot()
            miss = false
        }
    }
    
    
    @IBAction func add1(_ sender: Any) {
        if(miss == false){
            if(teamChosen == "team1"){
                score1 = score1 + 1
                team1[playerChosen]![quarter]!["Points"]! = team1[playerChosen]![quarter]!["Points"]! + 1
                team1[playerChosen]![quarter]!["FTM"]! = team1[playerChosen]![quarter]!["FTM"]! + 1
                team1[playerChosen]![quarter]!["FTA"]! = team1[playerChosen]![quarter]!["FTA"]! + 1

            } else {
                score2 = score2 + 1
                team2[playerChosen]![quarter]!["Points"]! = team2[playerChosen]![quarter]!["Points"]! + 1
                team2[playerChosen]![quarter]!["FTM"]! = team2[playerChosen]![quarter]!["FTM"]! + 1
                team2[playerChosen]![quarter]!["FTA"]! = team2[playerChosen]![quarter]!["FTA"]! + 1
                
            }
            updateScore()
            lastPoints = 1
            lastShot = "1p"
        } else {
            lastPoints = 1
            lastShot = "1p"
            missedShot()
            miss = false
        }
    }
    
    @IBAction func missButton(_ sender: Any) {
        miss = true
    }
    
    func missedShot(){
        if(teamChosen == "team1"){
            if(lastShot == "3p"){
                team1[playerChosen]![quarter]!["FGA"]! = team1[playerChosen]![quarter]!["FGA"]! + 1
                team1[playerChosen]![quarter]!["3PA"]! = team1[playerChosen]![quarter]!["3PA"]! + 1
            } else if(lastShot == "2p"){
                team1[playerChosen]![quarter]!["FGA"]! = team1[playerChosen]![quarter]!["FGA"]! + 1
            } else if(lastShot == "1p"){
                team1[playerChosen]![quarter]!["FTA"]! = team1[playerChosen]![quarter]!["FTA"]! + 1
            }

        } else {
            if(lastShot == "3p"){
                team2[playerChosen]![quarter]!["FGA"]! = team2[playerChosen]![quarter]!["FGA"]! + 1
                team2[playerChosen]![quarter]!["3PA"]! = team2[playerChosen]![quarter]!["3PA"]! + 1
            } else if(lastShot == "2p"){
                team2[playerChosen]![quarter]!["FGA"]! = team2[playerChosen]![quarter]!["FGA"]! + 1
            } else if(lastShot == "1p"){
                team2[playerChosen]![quarter]!["FTA"]! = team2[playerChosen]![quarter]!["FTA"]! + 1
            }

        }
    }
    
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
    }
    
    func updateScore(){
        score1Text.setTitle(String(score1), for: .normal)
        score2Text.setTitle(String(score2), for: .normal)
    }
    
    
    @IBAction func getRebounds(_ sender: Any) {
        if(teamChosen == "team1"){
            team1[playerChosen]![quarter]!["Rebounds"]! = team1[playerChosen]![quarter]!["Rebounds"]! + 1
         
        } else {
            team2[playerChosen]![quarter]!["Rebounds"]! = team2[playerChosen]![quarter]!["Rebounds"]! + 1
            
        }
    }
    
    //Stats Seque
    @IBAction func goToStats(_ sender: Any) {
        performSegue(withIdentifier: "statSegue", sender: (Any).self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "statSegue"{
            let destinationVC = segue.destination as! StatsViewController
            
            destinationVC.score1 = score1
            destinationVC.score2 = score2
            
            destinationVC.minutes = minutes
            destinationVC.seconds = seconds
            
            destinationVC.team1 = team1
            destinationVC.team2 = team2
            
            
            
        }
    }
    
}
