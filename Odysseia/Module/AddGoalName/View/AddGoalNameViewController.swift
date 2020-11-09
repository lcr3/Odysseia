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

    // Presenter -> View
    func validationError(msg: String)
}

class AddGoalNameViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: AddGoalNamePresentation!
    var pickerView = UIPickerView()
    var recentYears: [Int] = []

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var goalTitleField: UITextField!
    @IBOutlet weak var targetDedlineField: UITextField!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        recentYears = getRecentYears()
        setViews()
        guard let defaultYear = recentYears.first else {
            return
        }
        targetDedlineField.text = String(defaultYear)
        presenter.updateDedline(year: defaultYear)
    }

    // MARK: Action
    @IBAction func nextButtonTouched(_ sender: Any) {
        guard let title = goalTitleField.text else {
            // error
            return
        }
        presenter.nextButtonTouched(title: title)
    }

    @objc func donePicker() {
        targetDedlineField.endEditing(true)
    }

    private func getRecentYears() -> [Int] {
        let thisYear = Calendar.current.component(.year, from: Date())
        let years = [thisYear,
                     thisYear + 1,
                     thisYear + 2,
                     thisYear + 3]
        return years
    }

    private func setViews() {
        goalTitleField.delegate = self
        targetDedlineField.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        let targetDedlineToolbar = UIToolbar()
        targetDedlineToolbar.frame = toolbarFrame
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                             target: self,
                                             action: #selector(donePicker))
        targetDedlineToolbar.setItems([doneButtonItem], animated: true)
        targetDedlineField.inputAccessoryView = targetDedlineToolbar
    }
}

extension AddGoalNameViewController: AddGoalNameView {
    func changeButton(enable: Bool) {
        nextButton.isEnabled = enable
    }

    func validationError(msg: String) {
        let alert = UIAlertController.errorAlert(msg: msg)
        present(alert, animated: true)
    }
}

extension AddGoalNameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        presenter.updateGoal(name: string)
        return true
    }
}

extension AddGoalNameViewController: UIPickerViewDelegate {
}

extension AddGoalNameViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        recentYears.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(recentYears[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        targetDedlineField.text = String(recentYears[row])
        presenter.updateDedline(year: recentYears[row])
    }
}
