//
//  TaskView.swift
//  Odysseia
//
//  Created by okano on 2020/10/24.
//

import UIKit

class TaskView: UIView {

    @IBOutlet weak var circleArea: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        let nib = UINib(nibName: "TaskView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        addSubview(view)
    }

    func setTask(task: Task) {

    }
}
