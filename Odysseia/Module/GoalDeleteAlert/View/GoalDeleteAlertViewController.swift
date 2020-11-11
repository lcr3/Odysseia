//
//  GoalDeleteAlertViewController.swift
//  Odysseia
//
//  Created by lcr on 10/11/2020.
//

import UIKit

protocol GoalDeleteAlertView: AnyObject {
    var presenter: GoalDeleteAlertPresentation! { get }
    // View -> Presenter
    func set(goal: Goal)
}

class GoalDeleteAlertViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: GoalDeleteAlertPresentation!

    @IBOutlet private weak var taskNameLabel: UILabel!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    @IBAction func positiveButtonTouched(_ sender: Any) {
        presenter.positiveButtonTouched()
    }
    @IBAction func negativeButtonTouched(_ sender: Any) {
        presenter.negativeButtonTouched()
    }
}

extension GoalDeleteAlertViewController: GoalDeleteAlertView {
    func set(goal: Goal) {
        taskNameLabel.text = "\"" + goal.title + "\""
    }
}
