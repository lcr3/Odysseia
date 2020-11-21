//
//  SettingCell.swift
//  Odysseia
//
//  Created by lcr on 2020/11/20.
//

import UIKit

class SettingCell: UITableViewCell {
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }

    func setCell(item: SettingItem) {
        titleLabel.text = item.title
        thumbView.image = item.image
    }
}

extension UITableViewCell {

    @IBInspectable
    var selectedBackgroundColor: UIColor? {
        get {
            selectedBackgroundView?.backgroundColor
        }
        set(color) {
            let background = UIView()
            background.backgroundColor = color
            selectedBackgroundView = background
        }
    }

}
