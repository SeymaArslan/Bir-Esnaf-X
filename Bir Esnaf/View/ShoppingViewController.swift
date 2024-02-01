//
//  ShoppingViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 1.02.2024.
//

import UIKit

class ShoppingViewController: UIViewController {

    @IBOutlet weak var salePicker: UIPickerView!
    @IBOutlet weak var profitAmount: UILabel!
    @IBOutlet weak var totalProfitAmount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profitAmount.text = "0 ₺"
        totalProfitAmount.text = "0 ₺"
    }
    
    
    @IBAction func calculateButton(_ sender: Any) {
        
    }
    
// picker da sale de ki ürünlerin adı gelecek
    // diyelim ki kaydedilen maliyet 20 tl
    // picker da seçilen satılan ürünün satış fiyatı 25
    // kaç adet satıldığı bilgisini de alıp total
    // (fark) diyeceğiz = 25 - 20
    // toplam fark 5 * total diyeceğiz ve burada profitAmount buna eşit olacak
    // aslında otomatik kaydedecek sale kısmında ürün satışı girildiğinde shop veri tabanında
    // direkt insert işlemi olacak ve profitAmount alanına veri girecek sayı pozitifse Yeşil ile yazacak negatifse kırmızı
    // ardından total Profit Amount kısmına geleceğiz burada bir buton mu koysak.. hesapla gibi..
    // label ın yanında yer alsa ve hesaplaya basınca tetiklense :)

}
