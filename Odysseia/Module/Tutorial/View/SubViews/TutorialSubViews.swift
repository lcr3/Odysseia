//
//  TutorialSubViews.swift
//  Odysseia
//
//  Created by lcr on 2020/11/19.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

protocol ThirdViewControllerDelegate: AnyObject {
    func startButtonTouched()
}

class ThirdViewController: UIViewController {
    weak var delegate: ThirdViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startButtonTouched(_ sender: Any) {
        delegate?.startButtonTouched()
    }
}
