//
//  EditTaskViewController.swift
//  Odysseia
//
//  Created by lcr on 02/11/2020.
//

import Hero
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

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.hero.id = "taskView"
        hero.isEnabled = true
        presenter.viewDidLoad()
        titleField.text = presenter.task.title
        targetCountLabel.text = "\(presenter.task.reachCount) / \(presenter.task.targetCount)"
    }

    // MARK: Action
    @IBAction func incrementButtonTouched(_ sender: Any) {
        presenter.incrementButtonTouched()
    }

    @IBAction func decrementButtonTouched(_ sender: Any) {
        presenter.decrementButtonTouched()
    }

    @IBAction func doneButtonTouched(_ sender: Any) {
        presenter.doneButtonTouched()
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
