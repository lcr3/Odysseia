//
//  TaskInputModalViewController.swift
//  Odysseia
//
//  Created by ryookano on 2020/10/28.
//
import BottomHalfModal
import UIKit

protocol TaskInputDelegate: AnyObject {
    // Output
    func scceseAdd(title: String, targetLevel: Int)
}

class TaskInputModalViewController: UIViewController {
    @IBOutlet weak var targetLevelField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    let toolbarFrame = CGRect(x: 0,
                              y: 0,
                              width: UIScreen.main.bounds.width,
                              height: 44)
    var sheetContentHeightToModify: CGFloat = 500
    var pickerView = UIPickerView()
    weak var delegate: TaskInputDelegate?

    init(delegate: TaskInputDelegate?) {
        super.init(nibName: nil, bundle: Bundle(for: TaskInputModalViewController.self))
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(add))

        setTargetField()
        setTitleField()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adjustFrameToSheetContentHeightIfNeeded()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        adjustFrameToSheetContentHeightIfNeeded(with: coordinator)
    }

    func setTitleField() {
        titleField.delegate = self
        let titleToolbar = UIToolbar()
        titleToolbar.frame = toolbarFrame
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneInputTitle))
        titleToolbar.setItems([doneItem], animated: true)
        titleField.inputAccessoryView = titleToolbar
    }

    func setTargetField() {
        targetLevelField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self

        let targetLevelToolbar = UIToolbar()
        targetLevelToolbar.frame = toolbarFrame
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        targetLevelToolbar.setItems([doneButtonItem], animated: true)
        targetLevelField.inputAccessoryView = targetLevelToolbar
    }

    @objc func donePicker() {
        targetLevelField.endEditing(true)
    }

    @objc func doneInputTitle() {
        view.endEditing(true)
    }

    @objc func add() {
        // validation
        guard let title = titleField.text, !title.isEmpty, let targetText = targetLevelField.text, !targetText.isEmpty, let targetLevel = Int(targetText) else {
            // error
            return
        }
        dismiss(animated: true) {
            self.delegate?.scceseAdd(title: title, targetLevel: targetLevel)
            self.delegate = nil
        }
    }

    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @IBAction func cancelButtonTouched(_ sender: Any) {
        //        dismiss(animated: true, completion: nil)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        targetLevelField.endEditing(true)
    }
}

extension TaskInputModalViewController: SheetContentHeightModifiable {
    func adjustFrameToSheetContentHeightIfNeeded(with coordinator: UIViewControllerTransitionCoordinator) {

    }
}

extension TaskInputModalViewController: UIPickerViewDelegate {

}

extension TaskInputModalViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        99
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(row)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        targetLevelField.text = String(row)
    }
}

extension TaskInputModalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
