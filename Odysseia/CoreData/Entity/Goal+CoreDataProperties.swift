//
//  Goal+CoreDataProperties.swift
//  Odysseia
//
//  Created by lcr on 2020/10/30.
//

import Foundation
import CoreData

extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var deadlineDate: Date
    @NSManaged public var detail: String
    @NSManaged public var planet: Int16
    @NSManaged public var reatchDate: Date?
    @NSManaged public var title: String
    @NSManaged public var createdAt: Date
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension Goal {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension Goal: Identifiable {
    enum Key: String {
        case title
        case detail
        case planet
        case reatchDate
        case createdAt
        case tasks
    }

    func getTask(index: Int) -> Task {
        let tasks = getTasks()
        return tasks[index]
    }

    func getTasks() -> [Task] {
        guard let arrayTasks = tasks?.allObjects as? [Task] else {
            return []
        }
        return arrayTasks.sorted { $0.createdAt < $1.createdAt }
    }

    func isAllTasksDone() -> Bool {
        for task in getTasks() {
            if !task.isDone() {
                return false
            }
        }
        return true
    }

    func achievementRate() -> Int {
        var reachCount: Float = 0
        var targetCount: Float = 0
        for task in getTasks() {
            reachCount += Float(task.reachCount)
            targetCount += Float(task.targetCount)
        }
        let part = (reachCount / targetCount) * 100
        return Int(part)
    }

    func achievement() -> Achievement {
        var reachCount = 0
        var targetCount = 0
        for task in getTasks() {
            reachCount += Int(task.reachCount)
            targetCount += Int(task.targetCount)
        }
        return Achievement(reachCount: reachCount, targetCount: targetCount)
    }

    func deadlineDays() -> Int {
        let retInterval = deadlineDate.timeIntervalSince(Date())
        let ret = retInterval / 86400
        return Int(floor(ret))
    }

    func isReach() -> Bool {
        reatchDate != nil
    }
}

struct Achievement {
    let reachCount: Int
    let targetCount: Int
    func rate() -> Int {
        let reachFloat = Float(reachCount)
        let targetFloat = Float(targetCount)
        return Int(reachFloat / targetFloat * 100)
    }

}
