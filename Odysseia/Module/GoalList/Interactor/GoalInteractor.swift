//
//  GoalInteractor.swift
//  CoreDataSample
//
//  Created by lcr on 2020/10/19.
//
import CoreData
import UIKit

protocol GoalListUsecase: AnyObject {
    var output: GoalListInteractorOutput? { get }
    func addGoal()
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
    func addGoal() {
        //        do {
        //            try
        //        } catch {
        //
        //        }
    }
}
