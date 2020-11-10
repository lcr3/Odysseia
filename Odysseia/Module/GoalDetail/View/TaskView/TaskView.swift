//
//  TaskView.swift
//  Odysseia
//
//  Created by lcr on 2020/10/24.
//

import UIKit
import HGCircularSlider

protocol TaskViewDelegate: AnyObject {
    func taskTouched(index: Int)
}

class TaskView: UIView {
    weak var delegate: TaskViewDelegate?
    private var index = 0

    @IBOutlet weak var goalEmojiLabel: UILabel!
    @IBOutlet weak var achievementCircle: TaskAchievementCircle!
    @IBOutlet weak var targetCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    static func make(delegate: TaskViewDelegate, task: Task, index: Int) -> TaskView {
        guard let view = UINib(nibName: TaskView.className, bundle: nil)
                .instantiate(withOwner: nil, options: nil)
                .first as? TaskView else {
            fatalError("Faild load task view")
        }
        view.delegate = delegate
        view.index = index
        view.set(task: task)
        return view
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func taskViewtouched(_ sender: Any) {
        delegate?.taskTouched(index: index)
    }

    func set(task: Task) {
        titleLabel.text = task.title
        targetCountLabel.text = "\(task.reachCount) / \(task.targetCount)"
        achievementCircle.setCircle(task: task)
        if task.reachCount == 0 {
            goalEmojiLabel.text = "⏳"
            goalEmojiLabel.isHidden = false
            achievementCircle.isHidden = true
        } else if task.reachCount != task.targetCount {
            goalEmojiLabel.text = ""
            goalEmojiLabel.isHidden = true
            achievementCircle.isHidden = false
        } else {
            goalEmojiLabel.text = "🎊"
            goalEmojiLabel.isHidden = false
            achievementCircle.isHidden = true
        }
    }
}
