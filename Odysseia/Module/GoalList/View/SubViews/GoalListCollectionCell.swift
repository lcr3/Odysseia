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

        // cellの枠の太さ
        self.layer.borderWidth = 1.0
        // cellの枠の色
        self.layer.borderColor = UIColor.black.cgColor
        // cellを丸くする
        self.layer.cornerRadius = 8.0
    }

    func setCell(goal: Goal) {
        titleLabel.text = goal.title
        backgroundColor = Asset.moon.color
    }
}
