//
//  ChooseRosters.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 3/18/22.
//

import UIKit

protocol rostersRecieve {
    //protocol allows the rosters chosen to be sent to the CreateGameViewController
    func dataRecieved(team1List: [String], team2List: [String]) //CreateGameVC will conform to this function
}

class ChooseRosters: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //List of all players
    var players:[String] = ["Swabhan", "Prabhav", "Vince", "Anthony", "Zeke", "Aryan", "Sid", "Ian", "Chris", "Sumant", "Harshil"]
    
    //List of team's roster
    var team1:[String] = []
    var team2:[String] = []

    //The current team that is choosing variable
    var teamChosen = ""

    @IBOutlet weak var playerTableView: UITableView!
    
    var delegate : rostersRecieve? //View Controller that want to use rostersRecieved has to set delegate to self
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Table View Delegate and datasource setup
        playerTableView.delegate = self
        playerTableView.dataSource = self
        
        playerTableView.register(UINib(nibName: "rosterCell", bundle: nil), forCellReuseIdentifier: "rosterCell") //Allows custom cells
        
        
    }
    
    //Table View Select
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //Reloads tableview to make the updates to the UI
        let indexesToRedraw = [indexPath]
        tableView.reloadRows(at: indexesToRedraw, with: .fade)
        
        //Adds player to the team after they have been selected
        if(teamChosen == "team1" && team1.count <= 4){
            team1.append(players[indexPath.row])
        } else if(teamChosen == "team2" && team2.count <= 4) {
            team2.append(players[indexPath.row])
        } else {
            if(team1.contains(players[indexPath.row])){
                team1 = team1.filter(){$0 != players[indexPath.row]}
            } else if(team2.contains(players[indexPath.row])){
                team2 = team2.filter(){$0 != players[indexPath.row]}
            }
        }
        

    }
    
    //Set number of rows for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    //Sets values for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rosterCell", for: indexPath) as! rosterCell
       
        //Adds the name of each player to table view
        cell.name.text = players[indexPath.row]
    
        //Changes the background color to match the team the player is on
        let backgroundView = UIView()
        if(teamChosen == "team1" || team1.contains(players[indexPath.row])){
            cell.backgroundColor = .systemBlue
            cell.selectedBackgroundView = backgroundView
        } else if(teamChosen == "team2" || team2.contains(players[indexPath.row])){
            cell.backgroundColor = .orange
            cell.selectedBackgroundView = backgroundView
        } else if (teamChosen == "subOut"){
            cell.backgroundColor = .white
            cell.selectedBackgroundView = backgroundView
        }
        
        return cell
    }
    
    //Selects which team is choosing
    @IBAction func team1Button(_ sender: Any) {
        teamChosen = "team1"
    }
    
    @IBAction func team2Button(_ sender: Any) {
        teamChosen = "team2"
    }
    
    @IBAction func subOut(_ sender: Any) {
        teamChosen = "subOut"
    }
    
    
    //Segue back to create game screen
    @IBAction func setRosters(_ sender: Any) {
        //the VC that sets the delegate to self will have to use the dataRecieved function with the following arguments
        delegate?.dataRecieved(team1List: team1, team2List: team2)
        dismiss(animated: true, completion: nil)
    }
}
