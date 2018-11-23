//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Denis Bystruev on 13/11/2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    var menuItem: MenuItem! = MenuItem(
        id: 0,
        name: "Название блюда",
        detailText: "Описание блюда",
        price: 9.99,
        category: "Категория блюда",
        imageURL: URL(string: "https://apple.com")!
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToOrderButton.layer.cornerRadius = 5
        updateUI()
    }
    
    func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        detailTextLabel.text = menuItem.detailText
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func orderButtonTapped(_ button: UIButton){
        UIView.animate(withDuration: 0.3) {
            button.transform = CGAffineTransform(scaleX: 3, y: 3)
            button.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
}
