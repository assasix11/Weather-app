//
//  collectiCollectionViewCell.swift
//  DZ25
//
//  Created by Дмитрий Зубарев on 27.06.2021.
//

import UIKit

class collectiCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var dayName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
