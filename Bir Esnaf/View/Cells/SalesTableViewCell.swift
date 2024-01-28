//
//  SellTableViewCell.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import UIKit

class SalesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var salePrice: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var saleDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
