//
//  ServiceTests.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/25.
//

import XCTest
import CoreData
@testable import Odysseia

class ServiceTests: XCTestCase {
    var service: GoalServicer!

    override func setUp() {
        super.setUp()
        service = GoalServicer.shared
    }

    override func tearDown() {
        super.tearDown()
        do {
            try service.allDelete()
        } catch {
            XCTFail("Failed all delete.")
        }
    }

    func testAddGoalTask() {
        // setup
        let goal = TemporaryGoal(title: "test", detail: "detail", deadlineDate: Date())
        let tasks = [TemporaryTask(title: "task1", targetCount: 1),
                     TemporaryTask(title: "task2", targetCount: 2),
                     TemporaryTask(title: "task3", targetCount: 3)]

        // execute
        do {
            try _ = service.add(goal: goal, tasks: tasks)
        } catch {
            XCTFail("Failed add goal.")
        }

        let saveGoals: [Goal]
        do {
            saveGoals = try service.getAll()
        } catch {
            XCTFail("Failed get goal.")
            return
        }

        // verify
        guard let saveGoal = saveGoals.first else {
            return XCTFail("Failed get goal.")
        }

        XCTAssertEqual(saveGoals.count, 1)
        XCTAssertEqual(saveGoal.title, "test")
        XCTAssertEqual(saveGoal.detail, "detail")
        XCTAssertEqual(saveGoal.tasks?.count, 3)

        for (index, task) in saveGoal.getTasks().enumerated() {
            XCTAssertEqual(tasks[index].title, task.title)
            XCTAssertEqual(tasks[index].targetCount, Int(task.targetCount))
        }
    }

    func testUpdateGoal() {
        // setup
        guard let uuid = saveGoal(title: "title", detail: "detail", tasks: []) else {
            return XCTFail("Failed save goal.")
        }
        let editTitle = "editTitle"
        let editDetail = "editDetail"
        var editGoal: Goal
        do {
            try editGoal = service.get(uuid: uuid.uuidString)
        } catch {
            return XCTFail("Failed get goal.")
        }

        // execute
        editGoal.title = editTitle
        editGoal.detail = editDetail
        do {
            try _ = service.update(goal: editGoal)
        } catch {
            return XCTFail("Failed update goal.")
        }

        // verify
        guard let updateGoal = loadGoal(uuid: uuid) else {
            return XCTFail("Failed load goal.")
        }
        XCTAssertEqual(updateGoal.title, editTitle)
        XCTAssertEqual(updateGoal.detail, editDetail)
    }

    func testDeleteGoal() {
        // setup
        let tasks = [TemporaryTask(title: "task", targetCount: 3)]
        guard let uuid = saveGoal(title: "title", detail: "detail", tasks: tasks),
              let deleteGoal = loadGoal(uuid: uuid) else {
            return XCTFail("Failed load goal.")
        }

        // execute
        do {
            try service.delete(goal: deleteGoal)
        } catch {
            XCTFail("Failed delete goal.")
        }

        // verify
        do {
            try _ = service.get(uuid: uuid.uuidString)
            XCTFail("Faild delete goal.")
        } catch {
            // expectation
        }
    }

    func testGetGoal() {
        // setup
        let tasks1 = [TemporaryTask(title: "task1", targetCount: 1)]
        let tasks2 = [TemporaryTask(title: "task2", targetCount: 2)]
        guard let uuid1 = saveGoal(title: "title1", detail: "detail1", tasks: tasks1),
              let uuid2 = saveGoal(title: "title2", detail: "detail2", tasks: tasks2) else {
            return XCTFail("Failed save goal.")
        }

        // execute
        let getGoal1, getGoal2: Goal
        do {
            try getGoal1 = service.get(uuid: uuid1.uuidString)
            try getGoal2 = service.get(uuid: uuid2.uuidString)
        } catch {
            return XCTFail("Failed get goal.")
        }

        // verify
        XCTAssertEqual(getGoal1.title, "title1")
        XCTAssertEqual(getGoal1.detail, "detail1")
        XCTAssertEqual(getGoal1.getTasks().first?.title, "task1")
        XCTAssertEqual(getGoal1.getTasks().first?.targetCount, 1)
        XCTAssertEqual(getGoal2.title, "title2")
        XCTAssertEqual(getGoal2.detail, "detail2")
        XCTAssertEqual(getGoal2.getTasks().first?.title, "task2")
        XCTAssertEqual(getGoal2.getTasks().first?.targetCount, 2)
    }

    func testGetAll() {
        // setup
        let tasks1 = [TemporaryTask(title: "task1", targetCount: 1)]
        let tasks2 = [TemporaryTask(title: "task2", targetCount: 2)]
        _ = saveGoal(title: "title1", detail: "detail1", tasks: tasks1)
        _ = saveGoal(title: "title2", detail: "detail2", tasks: tasks2)

        // execute
        let goals: [Goal]
        do {
            try goals = service.getAll()
        } catch {
            return XCTFail("Failed get all.")
        }

        // verify
        let goal1 = goals[0]
        let goal2 = goals[1]
        XCTAssertEqual(goals.count, 2)
        XCTAssertEqual(goal1.title, "title1")
        XCTAssertEqual(goal1.detail, "detail1")
        XCTAssertEqual(goal1.getTasks().count, 1)
        XCTAssertEqual(goal1.getTasks().first?.title, "task1")
        XCTAssertEqual(goal1.getTasks().first?.targetCount, 1)
        XCTAssertEqual(goal2.title, "title2")
        XCTAssertEqual(goal2.detail, "detail2")
        XCTAssertEqual(goal2.getTasks().count, 1)
        XCTAssertEqual(goal2.getTasks().first?.title, "task2")
        XCTAssertEqual(goal2.getTasks().first?.targetCount, 2)
    }

    func testDeleteTask() {
        // setup
        let tasks = [TemporaryTask(title: "task1", targetCount: 3),
                     TemporaryTask(title: "task2", targetCount: 2)]
        guard let uuid = saveGoal(title: "title", detail: "detail", tasks: tasks),
              let targetGoal = loadGoal(uuid: uuid) else {
            return XCTFail("Failed load goal.")
        }

        // execute
        let deleteTask = targetGoal.getTask(index: 0)
        do {
            try service.delete(task: deleteTask)
        } catch {
            XCTFail("Failed delete task.")
        }

        // verify
        guard let goal = loadGoal(uuid: uuid) else {
            return XCTFail("Failed get goal.")
        }
        XCTAssertEqual(goal.getTasks().count, 1)
        XCTAssertEqual(goal.getTasks()[0].title, "task2")
        XCTAssertEqual(goal.getTasks()[0].targetCount, 2)
    }

    func testUpdateTask() {
        // setup
        let tasks = [TemporaryTask(title: "task1", targetCount: 3)]
        guard let uuid = saveGoal(title: "title", detail: "detail", tasks: tasks),
              let targetGoal = loadGoal(uuid: uuid) else {
            return XCTFail("Failed load goal.")
        }

        // execute
        let updateTask = targetGoal.getTask(index: 0)
        updateTask.title = "update"
        updateTask.targetCount = 99
        do {
            _ = try service.update(task: updateTask)
        } catch {
            return XCTFail("Failed update task.")
        }

        // verify
        guard let goal = loadGoal(uuid: uuid) else {
            return XCTFail("Failed get goal.")
        }
        XCTAssertEqual(goal.getTask(index: 0).title, "update")
        XCTAssertEqual(goal.getTask(index: 0).targetCount, 99)
    }

    private func saveGoal(title: String, detail: String, tasks: [TemporaryTask]) -> UUID? {
        let tempGoal = TemporaryGoal(title: title, detail: detail, deadlineDate: Date())
        do {
            let goal = try service.add(goal: tempGoal, tasks: tasks)
            return goal.id
        } catch {
            return nil
        }
    }

    private func loadGoal(uuid: UUID) -> Goal? {
        do {
            return try service.get(uuid: uuid.uuidString)
        } catch {
            return nil
        }
    }
}
