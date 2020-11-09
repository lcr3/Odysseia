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
        backgroundColor = .clear
        minimumValue = 0
        diskFillColor = .clear
        diskColor = .clear
        trackFillColor = Asset.venus.color
        backtrackLineWidth = 50
        trackShadowColor = .black
        trackShadowOffset = CGPoint(x: 100, y: 100)
        isUserInteractionEnabled = false
        lineWidth = 25
        trackColor = .clear
        thumbLineWidth = 0.0
        thumbRadius = 0.0
    }

    func setAchievementachievement(achievement: Achievement) {
        maximumValue = CGFloat(achievement.targetCount)
        endPointValue = CGFloat(achievement.reachCount)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
        minimumValue = 0
        diskFillColor = .clear
        diskColor = .clear
        trackFillColor = Asset.venus.color
        backtrackLineWidth = 50
        trackShadowColor = .black
        trackShadowOffset = CGPoint(x: 100, y: 100)
        isUserInteractionEnabled = false
        lineWidth = 25
        trackColor = .clear
        thumbLineWidth = 0.0
        thumbRadius = 0.0
    }
}
