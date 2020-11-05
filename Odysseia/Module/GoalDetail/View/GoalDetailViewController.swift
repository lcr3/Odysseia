//
//  GoalDetailViewController.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//  Copyright © 2020 lcr. All rights reserved.
//

import Hero
import UIKit

protocol GoalDetailView: AnyObject {
    func updateViews()
}

class GoalDetailViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: GoalDetailPresentation!

    private var achievementCircle = GoalAchievementCircle()
    private var taskViews: [TaskView] = []

    @IBOutlet private weak var titleField: UILabel!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentsStackView: UIStackView!
    @IBOutlet private weak var taskStackView: UIStackView!
    @IBOutlet private weak var achievementCircleArea: UIView!
    @IBOutlet private weak var deadlineDaysLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleField.text = presenter.goal.title
        deadlineDaysLabel.text = "\(presenter.goal.deadlineDays()) Days"
        percentLabel.text = "\(presenter.goal.achievementRate()) %"

        let frame = CGRect(x: (achievementCircleArea.frame.width - GoalAchievementCircle.width) / 2,
                           y: 0,
                           width: GoalAchievementCircle.width,
                           height: GoalAchievementCircle.height)
        achievementCircle = GoalAchievementCircle(frame: frame,
                                                  achievement: presenter.goal.achievement())
        achievementCircleArea.addSubview(achievementCircle)

        for (index, task) in presenter.goal.getTasks().enumerated() {
            let frame = CGRect(x: TaskView.xMergin,
                               y: (index * TaskView.height) + (index * TaskView.xMergin),
                               width: Int(self.taskStackView.frame.width) - TaskView.xMergin * 2,
                               height: TaskView.height)
            let taskView = TaskView.make(delegate: self, task: task, index: index)
            taskView.frame = frame
            taskView.hero.id = "taskView"
            taskStackView.addSubview(taskView)
            taskViews.append(taskView)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // TODO fix height value
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
    }

    @objc func editBarButtonTapped(_ sender: UIBarButtonItem) {
        presenter.editButtonTouched()
    }
}

extension GoalDetailViewController: GoalDetailView {
    func updateViews() {
        titleField.text = presenter.goal.title
        achievementCircle.endPointValue = CGFloat(presenter.goal.achievement().reachCount)
        percentLabel.text = "\(presenter.goal.achievementRate()) %"
        for (index, taskView) in taskViews.enumerated() {
            taskView.set(task: presenter.goal.getTask(index: index))
        }
    }
}

extension GoalDetailViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        presenter.loadGoal()
    }
}

extension GoalDetailViewController: TaskViewDelegate {
    func taskTouched(index: Int) {
        presenter.taskTouched(index: index)
    }
}
