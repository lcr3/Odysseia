//
//  GoalDetailViewController.swift
//  Odysseial
//
//  Created by lcr on 2020/10/20.
//  Copyright © 2020 lcr. All rights reserved.
//

import UIKit

protocol GoalDetailView: AnyObject {

}

class GoalDetailViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: GoalDetailPresentation!

    @IBOutlet weak var titleField: UILabel!
    @IBOutlet weak var detailField: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let editBarItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editBarButtonTapped(_:)))
        navigationItem.rightBarButtonItems = [editBarItem]

        titleField.text = presenter.goal.title
        detailField.text = presenter.goal.detail
    }

    @objc func editBarButtonTapped(_ sender: UIBarButtonItem) {
        presenter.editButtonTouched()
    }
}

extension GoalDetailViewController: GoalDetailView {

}

extension GoalDetailViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        //        presenter.loadGoals()
    }
}
