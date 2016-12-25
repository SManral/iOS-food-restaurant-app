//
//  DinnerPartyCell.swift
//  Paladar
//
//  Created by sasa cocic on 10/14/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit

class DinnerPartyCell: UITableViewCell {
    
    //index path is really just the section and row

    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var buyFoodAndAttendButton: UIView!
    
//    buyFoodAndAttendButton.addTarget(self, action: #selector(ClassName.FunctionName(_:), forControlEvents: .TouchUpInside)
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
