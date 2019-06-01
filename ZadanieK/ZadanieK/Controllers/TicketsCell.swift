//
//  TicketsCell.swift
//  ZadanieK
//
//  Created by Piotr_Brus on 30/05/2019.
//  Copyright © 2019 Piotr_Brus. All rights reserved.
//

import UIKit

class TicketsCell: UITableViewCell {

    @IBOutlet weak var tName: UILabel!
    @IBOutlet weak var tType: UILabel!
    @IBOutlet weak var tDescription: UILabel!
    @IBOutlet weak var tIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
