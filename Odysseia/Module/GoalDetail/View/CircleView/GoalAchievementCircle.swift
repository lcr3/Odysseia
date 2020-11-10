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
    var parcentLabel = UILabel()

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
        setParcentLabel()
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
        setParcentLabel()
    }

    func setAchievement(achievement: Achievement) {
        maximumValue = CGFloat(achievement.targetCount)
        endPointValue = CGFloat(achievement.reachCount)
        parcentLabel.text = "\(achievement.rate()) %"
    }

    private func setParcentLabel() {
        parcentLabel.frame = CGRect(x: 0,
                                    y: 0,
                                    width: frame.size.width,
                                    height: frame.size.height)
        parcentLabel.textAlignment = .center
        parcentLabel.backgroundColor = .clear
        addSubview(parcentLabel)
        parcentLabel.font = UIFont.boldSystemFont(ofSize: 35.0)
        parcentLabel.textColor = .white
    }
}
