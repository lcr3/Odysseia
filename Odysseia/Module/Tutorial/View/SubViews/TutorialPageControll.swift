//
//  TutorialPageControll.swift
//  Odysseia
//
//  Created by lcr on 2020/11/19.
//

import UIKit

class TutorialPageControll: UIPageControl {
    static let height: CGFloat = 60

    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setting()
    }

    private func setting() {
        currentPage = 0
        isUserInteractionEnabled = false
    }
}
