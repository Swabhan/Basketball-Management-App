//
//  rosterCell.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 3/18/22.
//

import UIKit

class rosterCell: UITableViewCell {

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
