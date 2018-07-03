//
//  AutoSuggestionCell.swift
//  AutoSuggestionBar
//
//  Created by Ilker Baltaci on 03.07.18.
//  Copyright © 2018 Ilker Baltaci. All rights reserved.
//

import UIKit

class AutoSuggestionCell: UICollectionViewCell {
    @IBOutlet var label: UILabel!
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 12
    }
    
    func setHighlighted(highlighted: Bool) {
        if highlighted {
            self.containerView.alpha = 0.5
        } else {
            self.containerView.alpha = 1.0
        }
    }
    
    
}
