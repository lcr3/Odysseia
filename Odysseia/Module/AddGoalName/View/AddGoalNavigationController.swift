//
//  AddGoalNavigationController.swift
//  Odysseia
//
//  Created by lcr on 2020/10/29.
//

import UIKit

protocol AddGoalDelegate: AnyObject {
    func successAddGoal()
}

class AddGoalNavigationController: UINavigationController {
    weak var addGoalDelegate: AddGoalDelegate?

    init(rootVc: UIViewController, delegate: AddGoalDelegate?) {
        super.init(rootViewController: rootVc)
        addGoalDelegate = delegate
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }

    func dismissSuccessAddGoal() {
        dismiss(animated: true) {
            self.addGoalDelegate?.successAddGoal()
            self.addGoalDelegate = nil
        }
    }
}
