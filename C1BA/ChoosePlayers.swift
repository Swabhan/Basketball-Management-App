//
//  ChoosePlayers.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 3/17/22.
//

import UIKit

class ChoosePlayers: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
    var players:[String] = ["Swabhan", "Prabhav", "Vince", "Anthony", "Zeke", "Aryan", "Sid", "Ian", "Chris", "Sumant"]
    
    var team1:[String] = []
    

    @IBOutlet weak var playerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        playerTableView.delegate = self
        playerTableView.dataSource = self
        
        playerTableView.register(UINib(nibName: "chooseRosterCell", bundle: nil), forCellReuseIdentifier: "chooseRosterCell") //Allows custom cells
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseRosterCell", for: indexPath) as! chooseRosterCell
        
        cell.name.text = players[indexPath.row]
        
        return cell
    }

}
