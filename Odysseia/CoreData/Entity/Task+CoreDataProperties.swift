//
//  Task+CoreDataProperties.swift
//  Odysseia
//
//  Created by lcr on 2020/10/30.
//

import Foundation
import CoreData

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var reachCount: Int16
    @NSManaged public var reachDate: Date?
    @NSManaged public var targetCount: Int16
    @NSManaged public var title: String
    @NSManaged public var createdAt: Date
    @NSManaged public var goal: Goal?

}

extension Task: Identifiable {
    func achievementRate() -> Int {
        let part = reachCount / targetCount * 100
        return Int(part)
    }

    func isDone() -> Bool {
        reachCount == targetCount
    }
}
