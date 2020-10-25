//
//  GoalDetailViewController.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//  Copyright © 2020 lcr. All rights reserved.
//

import UIKit
import HGCircularSlider

protocol GoalDetailView: AnyObject {
    func setGoal()
}

class GoalDetailViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: GoalDetailPresentation!
    var progressView = CircularSlider()
    @IBOutlet weak var titleField: UILabel!
    @IBOutlet weak var detailField: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentsStackView: UIStackView!
    @IBOutlet weak var taskStackView: UIStackView!
    @IBOutlet weak var progressViewArea: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let editBarItem = UIBarButtonItem(title: L10n.Localizable.editButtonText, style: .done, target: self, action: #selector(editBarButtonTapped(_:)))
        navigationItem.rightBarButtonItems = [editBarItem]
        setGoal()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let frame = CGRect(x: (progressViewArea.frame.width - 240) / 2, y: 0, width: 240, height: 240)
        progressView = CircularSlider(frame: frame)
        progressView.backgroundColor = .clear
        progressView.minimumValue = 0
        progressView.maximumValue = 5
        //        progressView.tintColor = Asset.mars.color
        progressView.diskFillColor = .clear
        progressView.diskColor = .clear
        progressView.trackColor = .red
        progressView.trackFillColor = Asset.venus.color
        progressView.backtrackLineWidth = 50
        progressView.trackShadowColor = .black
        progressView.trackShadowOffset = CGPoint(x: 100, y: 100)

        progressView.endPointValue = 2
        progressView.isUserInteractionEnabled = false
        progressView.lineWidth = 25
        progressView.trackColor = .clear
        // to remove padding, for more details see issue #25
        progressView.thumbLineWidth = 0.0
        progressView.thumbRadius = 0.0
        progressViewArea.addSubview(progressView)

        let tasks = ["a", "i", "u"]
        for (index, task) in tasks.enumerated() {

            let taskView = TaskView(frame: CGRect(x: 0,
                                                  y: index * 120,
                                                  width: Int(self.taskStackView.frame.width),
                                                  height: 120))
            let circle = CircularSlider(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: taskView.circleArea.frame.width,
                                                      height: taskView.circleArea.frame.height))
            //            taskView.setTask()
            taskView.addSubview(circle)
            taskStackView.addSubview(taskView)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        print(contentsStackView.bounds.height)
        print(scrollView.contentSize)
        //        scrollView.contentSize = contentsStackView.bounds.size
        scrollView.contentSize = CGSize(width: 414, height: 1000)

        print(scrollView.contentSize)
        //        scrollView.flashScrollIndicators()

    }

    @objc func editBarButtonTapped(_ sender: UIBarButtonItem) {
        //        print(contentsStackView.frame)
        progressView.endPointValue += CGFloat(0.5)
        //        presenter.editButtonTouched()
    }
}

extension GoalDetailViewController: GoalDetailView {
    func setGoal() {
        //        titleField.text = presenter.goal.title
        //        detailField.text = presenter.goal.detail
    }
}

extension GoalDetailViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        presenter.loadGoal()
    }
}
