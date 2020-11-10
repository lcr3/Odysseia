//
//  GoalListCollectionCell.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import UIKit

class GoalListCollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setCell(goal: Goal) {
        titleLabel.text = goal.title
    }
}
