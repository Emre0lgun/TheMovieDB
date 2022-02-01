//
//  FavoritiesTableViewCell.swift
//  TheMovieDB
//
//  Created by Emre OLGUN on 28.01.2022.
//

import UIKit

class FavoritiesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
