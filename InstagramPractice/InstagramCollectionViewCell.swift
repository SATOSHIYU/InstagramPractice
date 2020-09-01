//
//  InstagramCollectionViewCell.swift
//  InstagramPractice
//
//  Created by HSIEH CHIH YU on 2020/8/24.
//

import UIKit

class InstagramCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoImageView: UIImageView!
    static let width = floor((UIScreen.main.bounds.width - 1 * 2) / 3)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthConstraint.constant = InstagramCollectionViewCell.width
    }
}
