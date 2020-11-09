//
//  GoalNavigationController.swift
//  Odysseia
//
//  Created by lcr on 2020/10/21.
//

import UIKit

class GoalNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = Asset.venus.color
    }
}
