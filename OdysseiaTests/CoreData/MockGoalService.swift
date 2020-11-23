//
//  MockGoalService.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/10/22.
//

import CoreData
import XCTest
@testable import Odysseia

class MockGoalService: GoalServiceProtocol {
    var callCountAdd = 0
    var callCountAddGoalTasks = 0
    var callCountUpdate = 0
    var callCountDelete = 0
    var callCountGet = 0
    var callCountGetAll = 0
    var callCountUpdateTask = 0
    var mockGoal = Goal()
    var mockTask = Task()

    func add(goal: TemporaryGoal) throws -> Goal {
        callCountAdd += 1
        return mockGoal
    }

    func add(goal: TemporaryGoal, tasks: [TemporaryTask]) throws -> Goal {
        callCountAddGoalTasks += 1
        return mockGoal
    }

    func update(goal: Goal) throws -> Goal {
        callCountUpdate += 1
        return mockGoal
    }

    func delete(goal: Goal) throws {
        callCountDelete += 1
    }

    func get(objectId: NSManagedObjectID) throws -> Goal {
        callCountGet += 1
        return mockGoal
    }

    func getAll() throws -> [Goal] {
        callCountGetAll += 1
        return [mockGoal]
    }

    func update(task: Task) throws -> Task {
        callCountUpdateTask += 1
        return mockTask
    }
}
