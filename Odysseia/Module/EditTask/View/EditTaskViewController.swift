//
//  EditTaskViewController.swift
//  Odysseia
//
//  Created by lcr on 02/11/2020.
//

import UIKit

protocol EditTaskView: AnyObject {
    var presenter: EditTaskPresentation! { get }
    // Presenter -> View
    func showErrorAlert(msg: String)
    func setReachCount(text: String)
}

class EditTaskViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: EditTaskPresentation!

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var targetCountLabel: UILabel!
    @IBOutlet weak var popupView: UIView!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        presenter.viewDidLoad()
        titleField.delegate = self
        titleField.text = presenter.task.title
        targetCountLabel.text = "\(presenter.task.reachCount) / \(presenter.task.targetCount)"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        dismiss(animated: true)
    }

    @IBAction func updateButtonTouched(_ sender: Any) {
        presenter.updateButtonTouched()
    }
}

extension EditTaskViewController: EditTaskView {
    func showErrorAlert(msg: String) {
        let alert = UIAlertController.errorAlert(msg: msg)
        present(alert, animated: true)
    }

    func setReachCount(text: String) {
        targetCountLabel.text = text
    }
}

extension EditTaskViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        presenter.updateTitle(title: string)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.endEditing(true)
        return false
    }
}
