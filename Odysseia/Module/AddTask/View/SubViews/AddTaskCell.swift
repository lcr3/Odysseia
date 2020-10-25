//
//  AddTaskCell.swift
//  Odysseia
//
//  Created by lcr on 2020/10/27.
//

import UIKit

class AddTaskCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var targetLevelLabel: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // cellの枠の太さ
        self.layer.borderWidth = 1.0
        // cellの枠の色
        self.layer.borderColor = UIColor.black.cgColor
        // cellを丸くする
        self.layer.cornerRadius = 8.0
    }

    func setCell(task: TemporaryTask) {
        titleLabel.text = task.title
        targetLevelLabel.text = String(task.targetCount)
    }
}
