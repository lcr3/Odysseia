//
//  SettingAboutCell.swift
//  Odysseia
//
//  Created by lcr on 2020/11/20.
//

import UIKit

class SettingAboutCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        accessoryType = .disclosureIndicator
        contentView.backgroundColor = .clear
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        if let arrowButton = allSubviews.compactMap({ $0 as? UIButton }).last {
            let image = arrowButton.backgroundImage(for: .normal)?.withRenderingMode(.alwaysTemplate)
            arrowButton.setBackgroundImage(image, for: .normal)
            arrowButton.tintColor = Asset.mercury.color
        }
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            backgroundColor = Asset.mercury.color
            for item in self.subviews where (item as? UIButton) != nil {
                item.superview?.backgroundColor = Asset.mercury.color
            }
        } else {
            backgroundColor = Asset.settingAboutCell.color
            for item in self.subviews where (item as? UIButton) != nil {
                item.superview?.backgroundColor = Asset.settingAboutCell.color
            }
        }
    }

    func setCell(item: SettingAboutItem) {
        title.text = item.title
    }
}

extension UIView {
    var allSubviews: [UIView] {
        subviews.flatMap { [$0] + $0.allSubviews }
    }
}
