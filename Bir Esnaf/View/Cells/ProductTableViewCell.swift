//
//  ProductTableViewCell.swift
//  Bir Esnaf
//
//  Created by Seyma on 8.01.2024.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var totalNumber: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var priceNumber: UILabel!
    @IBOutlet weak var viewChange: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
