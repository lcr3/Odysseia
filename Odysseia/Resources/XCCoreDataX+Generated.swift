// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable superfluous_disable_command implicit_return
// swiftlint:disable sorted_imports
import CoreData
import Foundation

// swiftlint:disable attributes file_length vertical_whitespace_closing_braces
// swiftlint:disable identifier_name line_length type_body_length

// MARK: - Goal

internal class Goal: NSManagedObject {
    internal class var entityName: String {
        return "Goal"
    }

    internal class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
    }

    @available(*, deprecated, renamed: "makeFetchRequest", message: "To avoid collisions with the less concrete method in `NSManagedObject`, please use `makeFetchRequest()` instead.")
    @nonobjc internal class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: entityName)
    }

    @nonobjc internal class func makeFetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: entityName)
    }

    // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
    @NSManaged internal var deadlineDate: Date
    @NSManaged internal var detail: String
    @NSManaged internal var planet: Int16
    @NSManaged internal var reatchDate: Date?
    @NSManaged internal var title: String
    @NSManaged internal var tasks: Set<Task>?
    // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: Relationship Tasks

extension Goal {
    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: Set<Task>)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: Set<Task>)
}

// MARK: - Task

internal class Task: NSManagedObject {
    internal class var entityName: String {
        return "Task"
    }

    internal class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
    }

    @available(*, deprecated, renamed: "makeFetchRequest", message: "To avoid collisions with the less concrete method in `NSManagedObject`, please use `makeFetchRequest()` instead.")
    @nonobjc internal class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: entityName)
    }

    @nonobjc internal class func makeFetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: entityName)
    }

    // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
    @NSManaged internal var reachCount: Int16
    @NSManaged internal var reachDate: Date?
    @NSManaged internal var targetCount: Int16
    @NSManaged internal var title: String
    @NSManaged internal var goal: Goal?
    // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// swiftlint:enable identifier_name line_length type_body_length
