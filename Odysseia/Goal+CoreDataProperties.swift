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
    @NSManaged public var isReach: Bool
    @NSManaged public var planet: Int16
    @NSManaged public var reatchDate: Date?
    @NSManaged public var title: String
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
    func getTask(index: Int) -> Task {
        let tasks = getTasks()
        return tasks[index]
    }

    func getTasks() -> [Task] {
        guard let arrayTasks = tasks?.allObjects as? [Task] else {
            return []
        }
        return arrayTasks
    }

    func achievementRate() -> Int {
        var reachCount: Int16 = 0
        var targetCount: Int16 = 0
        for task in getTasks() {
            reachCount += task.reachCount
            targetCount += task.targetCount
        }
        let part = reachCount / targetCount * 100
        return Int(part)
    }

    func toString() {
        print("title: \(title)\n detail: \(detail)\n isReach: \(isReach)\n deadlineDate: \(deadlineDate)\n reatchDate: \(reatchDate)\n planet: \(planet)/n ")
    }
}
