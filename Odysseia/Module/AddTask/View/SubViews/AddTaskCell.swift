//
//  AddTaskCell.swift
//  Odysseia
//
//  Created by lcr on 2020/10/27.
//

import UIKit

class AddTaskCell: UICollectionViewCell {
    public static let height: CGFloat = 110

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var targetLevelLabel: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 8.0
    }

    func setCell(task: TemporaryTask) {
        titleLabel.text = task.title
        targetLevelLabel.text = String(task.targetCount)
    }
}
