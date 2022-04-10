//
//  gameStatCell.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 3/13/22.
//

import UIKit

class gameStatCell: UITableViewCell {

    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var assists: UILabel!
    @IBOutlet weak var rebounds: UILabel!
    @IBOutlet weak var steals: UILabel!
    @IBOutlet weak var turnovers: UILabel!
    @IBOutlet weak var fga: UILabel!
    @IBOutlet weak var fgm: UILabel!
    @IBOutlet weak var threepm: UILabel!
    @IBOutlet weak var threepa: UILabel!
    @IBOutlet weak var ftm: UILabel!
    @IBOutlet weak var fta: UILabel!
    @IBOutlet weak var name: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
