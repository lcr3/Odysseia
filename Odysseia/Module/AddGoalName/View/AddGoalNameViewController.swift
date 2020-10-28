//
//  AddGoalNameViewController.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

import UIKit

protocol AddGoalNameView: AnyObject {
    var presenter: AddGoalNamePresentation! { get }
    // View -> Presenter
    func viewDidLoad()

    func changeButton(enable: Bool)
}

class AddGoalNameViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: AddGoalNamePresentation!

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var goalTitleField: UITextField!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTitleField.delegate = self
    }

    @IBAction func nextButtonTouched(_ sender: Any) {
        presenter.nextButtonTouched()
    }
}

extension AddGoalNameViewController: AddGoalNameView {
    func changeButton(enable: Bool) {
        nextButton.isEnabled = enable
    }
}

extension AddGoalNameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        presenter.updateGoal(name: string)
        return true
    }
}
