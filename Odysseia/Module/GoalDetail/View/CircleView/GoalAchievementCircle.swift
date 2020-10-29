//
//  GoalAchievementCircle.swift
//  Odysseia
//
//  Created by lcr on 2020/11/05.
//

import HGCircularSlider
import UIKit

final class GoalAchievementCircle: CircularSlider {
    static let width: CGFloat = 240
    static let height: CGFloat = 240

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
        backtrackLineWidth = 50
        trackShadowColor = .black
        trackShadowOffset = CGPoint(x: 100, y: 100)

        endPointValue = CGFloat(achievement.reachCount)
        isUserInteractionEnabled = false
        lineWidth = 25
        trackColor = .clear
        thumbLineWidth = 0.0
        thumbRadius = 0.0
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
