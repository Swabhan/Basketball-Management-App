//
//  ChooseRosters.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 3/18/22.
//

import UIKit

class ChooseRosters: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var players:[String] = ["Swabhan", "Prabhav", "Vince", "Anthony", "Zeke", "Aryan", "Sid", "Ian", "Chris", "Sumant"]
    
    var team1:[String] = []
    var team2:[String] = []

    var teamChosen = "team1"

    @IBOutlet weak var playerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        playerTableView.delegate = self
        playerTableView.dataSource = self
        
        playerTableView.register(UINib(nibName: "rosterCell", bundle: nil), forCellReuseIdentifier: "rosterCell") //Allows custom cells
        
    }
    
    //Table View Select
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(teamChosen == "team1"){
            team1.append(players[indexPath.row])
        } else {
            team2.append(players[indexPath.row])
        }
        
        print(team1)
    }
    
    //Set number of rows for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    //Sets values for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rosterCell", for: indexPath) as! rosterCell
       
        cell.name.text = players[indexPath.row]
           
        
        return cell
    }
    
    @IBAction func team1Button(_ sender: Any) {
        teamChosen = "team1"
    }
    
    @IBAction func team2Button(_ sender: Any) {
        teamChosen = "team2"
    }
    
}
