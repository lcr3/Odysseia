//
//  EditGoalViewController.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import UIKit

protocol EditGoalView: AnyObject {

}

class EditGoalViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: EditGoalPresentation!

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = presenter.editGoal.title
        detailField.text = presenter.editGoal.detail
    }

    @IBAction func doneButtonTouched(_ sender: Any) {
        guard let title = titleField.text else {
            return
        }
        guard let detail = detailField.text else {
            return
        }
        presenter.doneButtonTouched(title: title, detail: detail)
    }
}

extension EditGoalViewController: EditGoalView {

}
