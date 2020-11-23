//
//  GoalDetailViewController.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//  Copyright © 2020 lcr. All rights reserved.
//

import SceneKit
import UIKit

protocol GoalDetailView: AnyObject {
    func updateViews()
}

class GoalDetailViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: GoalDetailPresentation!

    @IBOutlet private weak var achievementCircle: GoalAchievementCircle!
    @IBOutlet private weak var titleField: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var taskStackView: UIStackView!
    @IBOutlet private weak var deadlineDaysLabel: UILabel!

    private var confettiView = ConfettiView.make()
    private var taskViews: [TaskView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = presenter.goal.title
        deadlineDaysLabel.text = "\(presenter.goal.deadlineDays()) Days"
        achievementCircle.setAchievement(achievement: presenter.goal.achievement())
        view.addSubview(confettiView)
        for (index, task) in presenter.goal.getTasks().enumerated() {
            let taskView = TaskView.make(delegate: self, task: task, index: index)
            taskStackView.addArrangedSubview(taskView)
            taskViews.append(taskView)
        }
        checkGoalState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @objc func editBarButtonTapped(_ sender: UIBarButtonItem) {
        //        presenter.editButtonTouched()
    }

    private func checkGoalState() {
        if presenter.goal.isAllTasksDone() {
            confettiView.startAnimation()
        } else {
            confettiView.stopAnimation()
        }
    }
}

extension GoalDetailViewController: GoalDetailView {
    func updateViews() {
        titleField.text = presenter.goal.title
        achievementCircle.setAchievement(achievement: presenter.goal.achievement())
        for (index, taskView) in taskViews.enumerated() {
            taskView.set(task: presenter.goal.getTask(index: index))
        }
        checkGoalState()
    }
}

extension GoalDetailViewController: TaskViewDelegate {
    func taskTouched(index: Int) {
        presenter.taskTouched(index: index)
    }
}
