//
//  TipTableViewCell.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/19/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import UIKit

class TipTableViewCell: UITableViewCell {
    
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var personTip: PerPersonTip? {
        didSet {
            if (personTip != nil) {
                peopleLabel.text = String(personTip!.numberOfPeople)
            }
            tipLabel.text = personTip?.tip
            totalLabel.text = personTip?.total
        }
    }
}
