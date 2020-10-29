//
//  TaskAchievementCircle.swift
//  Odysseia
//
//  Created by lcr on 2020/11/05.
//

import HGCircularSlider
import UIKit

final class TaskAchievementCircle: CircularSlider {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(frame: CGRect, achievement: Achievement) {
        super.init(frame: frame)
        backgroundColor = .clear
        minimumValue = 0
        maximumValue = CGFloat(achievement.targetCount)
        diskFillColor = .clear
        diskColor = .clear
        trackFillColor = Asset.venus.color
        trackShadowColor = .black
        trackShadowOffset = CGPoint(x: 100, y: 100)

        endPointValue = CGFloat(achievement.targetCount)
        isUserInteractionEnabled = false
        lineWidth = 25
        trackColor = .clear
        thumbLineWidth = 0.0
        thumbRadius = 0.0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
        minimumValue = 0
        maximumValue = 999
        endPointValue = 0
        diskFillColor = .clear
        diskColor = .clear
        trackFillColor = Asset.venus.color
        backtrackLineWidth = 16
        trackShadowColor = .black
        trackShadowOffset = CGPoint(x: 100, y: 100)

        isUserInteractionEnabled = false
        lineWidth = 8
        trackColor = .clear

        thumbLineWidth = 0
        thumbRadius = 0
    }

    func setCircle(task: Task) {
        maximumValue = CGFloat(task.targetCount)
        endPointValue = CGFloat(task.reachCount)
    }
}
