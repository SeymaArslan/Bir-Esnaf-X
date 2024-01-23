//
//  ProductTableViewCell.swift
//  Bir Esnaf
//
//  Created by Seyma on 8.01.2024.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel! // ürün adı
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var totalNumber: UILabel!  // adet sayı
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var priceNumber: UILabel!  // adet fiyat
    @IBOutlet weak var viewChange: UIView!  // her üründe bir renk değiştirecek? 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
