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
        let doneBarItem = UIBarButtonItem(title: L10n.Localizable.doneButtonText, style: .done, target: self, action: #selector(doneBarButtonTapped(_:)))
        navigationItem.rightBarButtonItems = [doneBarItem]

        titleField.text = presenter.editGoal.title
        detailField.text = presenter.editGoal.detail
    }

    @objc func doneBarButtonTapped(_ sender: UIBarButtonItem) {
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

extension EditGoalViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}
