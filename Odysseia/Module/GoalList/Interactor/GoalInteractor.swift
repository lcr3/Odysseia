//
//  GoalInteractor.swift
//  CoreDataSample
//
//  Created by lcr on 2020/10/19.
//
import CoreData

protocol GoalListUsecase: AnyObject {
    var output: GoalListInteractorOutput? { get }
    func loadGoalList()
}

class GoalListInteractor {
    weak var output: GoalListInteractorOutput?
    private let goalService = GoalServicer.shared
}

extension GoalListInteractor: GoalListUsecase {
    func loadGoalList() {
        do {
            let goals = try goalService.getAll()
            output?.successLoad(goals: goals)
        } catch {
            output?.failedLoad(error: error)
        }
    }
}
