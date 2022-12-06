//
//  MovieCell.swift
//  MovieApp
//
//  Created by Osman Emre Ömürlü on 27.11.2022.
//

import UIKit

class MovieCell: UITableViewCell {
    
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

