//
//  GoalDetailViewController.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//  Copyright © 2020 lcr. All rights reserved.
//

import UIKit

protocol GoalDetailView: AnyObject {
    func updateViews()
}

class GoalDetailViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: GoalDetailPresentation!

    //    private var achievementCircle = GoalAchievementCircle()
    @IBOutlet weak var achievementCircle: GoalAchievementCircle!

    private var taskViews: [TaskView] = []

    @IBOutlet private weak var titleField: UILabel!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentsStackView: UIStackView!
    @IBOutlet private weak var taskStackView: UIStackView!
    @IBOutlet private weak var achievementCircleArea: UIView!
    @IBOutlet private weak var deadlineDaysLabel: UILabel!

    @IBOutlet weak var scrollOriginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        titleField.text = presenter.goal.title
        deadlineDaysLabel.text = "\(presenter.goal.deadlineDays()) Days"
        percentLabel.text = "\(presenter.goal.achievementRate()) %"
        achievementCircle.setAchievementachievement(achievement: presenter.goal.achievement())
        for (index, task) in presenter.goal.getTasks().enumerated() {
            let frame = CGRect(x: TaskView.xMergin,
                               y: (index * TaskView.height) + (index * TaskView.xMergin),
                               width: Int(self.taskStackView.frame.width) - TaskView.xMergin * 2,
                               height: TaskView.height)
            let taskView = TaskView.make(delegate: self, task: task, index: index)
            taskView.frame = frame
            taskStackView.addSubview(taskView)
            taskViews.append(taskView)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // TODO contentSize"数値目標を設定"
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 2000)
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

extension GoalDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

extension GoalDetailViewController: TaskViewDelegate {
    func taskTouched(index: Int) {
        presenter.taskTouched(index: index)
    }
}
