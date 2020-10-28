//
//  AddGoalViewController.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import UIKit

enum Planet: Int {
    case mercury
    case venus
    case earth
    case moon
    case mars
    static let defaultValue = Self.mercury

    init(value: Int) {
        if Self.venus.rawValue == value {
            self = .venus
        } else if Self.earth.rawValue == value {
            self = .earth
        } else if Self.moon.rawValue == value {
            self = .moon
        } else if Self.mars.rawValue == value {
            self = .mars
        } else {
            self = .mercury
        }
    }
}

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
    @IBOutlet weak var mercuryButton: UIButton!
    @IBOutlet weak var venusButton: UIButton!
    @IBOutlet weak var earthButton: UIButton!
    @IBOutlet weak var moonButton: UIButton!
    @IBOutlet weak var marsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let doneBarItem = UIBarButtonItem(title: L10n.Localizable.doneButtonText, style: .done, target: self, action: #selector(doneBarButtonTapped(_:)))
        navigationItem.rightBarButtonItems = [doneBarItem]
    }

    // Action
    @objc func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleField.text else {
            return
        }
        guard let detail = detailField.text else {
            return
        }
        presenter.addButtonTouched(title: title, detail: detail)
    }

    @IBAction func starButtonTouched(_ sender: UIButton) {
        let planet: Planet
        switch sender {
        case venusButton:
            planet = .venus
        case earthButton:
            planet = .earth
        case moonButton:
            planet = .moon
        case marsButton:
            planet = .mars
        default:
            planet = .mercury
        }
        presenter.planetButtonTouched(planet: planet)
    }
}

extension AddGoalViewController: AddGoalView {
    func showAddErrorMessageView(reason: String) {
        // todo エラー処理
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
