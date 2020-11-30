//
//  TaskInputViewController.swift
//  Odysseia
//
//  Created by lcr on 10/11/2020.
//

import UIKit

protocol TaskInputView: AnyObject {
    var presenter: TaskInputPresentation! { get }
    // View -> Presenter
    func viewDidLoad()
    func showErrorAlert(msg: String)
    func setTargetCount(text: String)
}

class TaskInputViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: TaskInputPresentation!

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var targetCountLabel: UILabel!
    @IBOutlet weak var popupView: UIView!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        titleField.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleField.endEditing(true)
    }

    // MARK: Action
    @IBAction func incrementButtonTouched(_ sender: Any) {
        presenter.incrementButtonTouched()
    }

    @IBAction func decrementButtonTouched(_ sender: Any) {
        presenter.decrementButtonTouched()
    }

    @IBAction func cancelButtonTouched(_ sender: Any) {
        presenter.cancelButtonTouched()
    }

    @IBAction func addTaskButtonTouched(_ sender: Any) {
        presenter.addTaskButtonTouched(title: titleField.text)
    }
}

extension TaskInputViewController: TaskInputView {
    func showErrorAlert(msg: String) {
        let alert = UIAlertController.errorAlert(msg: msg)
        present(alert, animated: true)
    }

    func setTargetCount(text: String) {
        targetCountLabel.text = text
    }
}

extension TaskInputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.endEditing(true)
        return false
    }
}
