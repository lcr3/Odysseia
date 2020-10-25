//
//  GoalDetailInteractor.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import CoreData

protocol GoalDetailUsecase: AnyObject {
    var output: GoalDetailInteractorOutput? { get }
    func loadGoalList(objectId: NSManagedObjectID)
}

class GoalDetailInteractor {
    weak var output: GoalDetailInteractorOutput?
    private let goalService = GoalServicer.shared
}

extension GoalDetailInteractor: GoalDetailUsecase {
    func loadGoalList(objectId: NSManagedObjectID) {
        do {
            let goal = try goalService.get(objectId: objectId)
            output?.successLoad(goal: goal)
        } catch {
            output?.failedLoad(error: error)
        }
    }
}
