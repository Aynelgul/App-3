//
//  MovieCell.swift
//  aynelgul-pset3
//
//  Created by Aynel Gül on 16-11-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
        
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDiscription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
