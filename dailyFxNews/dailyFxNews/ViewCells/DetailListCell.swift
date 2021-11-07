//
//  DetailListCell.swift
//  dailyFxNews
//
//  Created by raja padala on 07/11/21.
//

import UIKit

class DetailListCell: UITableViewCell, ViewGradientProtocol {
    var color1: UIColor = UIColor.clear
    var color2: UIColor = UIColor.black
    

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.applyGradientBackground(view: newsImage, isTopToBottom: true)
        self.backView.layer.borderWidth = 1
        self.backView.layer.cornerRadius = 10
        self.backView.layer.borderColor = UIColor.clear.cgColor
        self.backView.layer.masksToBounds = true
        self.newsImage.layer.cornerRadius = 10
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
