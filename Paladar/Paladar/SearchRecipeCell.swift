//
//  SearchRecipeCell.swift
//  Paladar
//
//  Created by Smriti Manral on 11/7/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit

class SearchRecipeCell: UITableViewCell {
    
    
    @IBOutlet weak var RecipeNameTA: UITextView!
    
    @IBOutlet var RecipeImage: UIImageView!

    @IBOutlet var RecipeTime: UILabel!
    
    @IBOutlet var TimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RecipeNameTA.userInteractionEnabled = false
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
