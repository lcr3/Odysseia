//
//  AddGoalViewController.swift
//  Odysseial
//
//  Created by lcr on 2020/10/20.
//

import UIKit

protocol AddGoalView: AnyObject {
    //    func checkinFailed(message: String)
    //
    var presenter: AddGoalPresentation! { get }
    func showAddErrorMessageView(reason: String)
}

class AddGoalViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: AddGoalPresentation!

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Action
    @IBAction func addButtonTouched(_ sender: Any) {
        guard let title = titleField.text else { return }
        guard let detail = detailField.text else { return }
        presenter.addButtonTouched(title: title, detail: detail)
    }
}

extension AddGoalViewController: AddGoalView {
    func showAddErrorMessageView(reason: String) {

    }
}

extension AddGoalViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}
