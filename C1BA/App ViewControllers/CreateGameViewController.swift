//
//  CreateGameViewController.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 4/3/22.
//

import UIKit

class CreateGameViewController: UIViewController, rostersRecieve {
    //Where the players get stored when they get selected
    var team1Players: [String] = []
    var team2Players: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func dataRecieved(team1List: [String], team2List: [String]) { //gets data from chooseRosters view controller through a protocol
        team1Players = team1List
        team2Players = team2List

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setPlayersSegue"{
            let vc = segue.destination as! ChooseRosters
            
            //gives the chooseRosters VC the current rosters already chosen
            vc.team1 = team1Players
            vc.team2 = team2Players
            
            vc.delegate = self //will now be able to use the function from the delegate in the chooseRosters VC
            
            vc.modalPresentationStyle = .fullScreen //makes segued view controlle full screen
        }
        
        if segue.identifier == "startGameSegue"{
            let vc = segue.destination as! ViewController
            
            //Gives the game VC the current rosters
            vc.roster1 = team1Players
            vc.roster2 = team2Players
            
            vc.modalPresentationStyle = .fullScreen //makes segued view controlle full screen
        }
    }

}
