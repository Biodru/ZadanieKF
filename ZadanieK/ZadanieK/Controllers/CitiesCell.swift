//
//  CitiesCell.swift
//  ZadanieK
//
//  Created by Piotr_Brus on 29/05/2019.
//  Copyright © 2019 Piotr_Brus. All rights reserved.
//

import UIKit

class CitiesCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
