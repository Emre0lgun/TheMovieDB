//
//  WatchListTableTableViewCell.swift
//  TheMovieDB
//
//  Created by Emre OLGUN on 27.01.2022.
//

import UIKit

class WatchListTableTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
