//
//  GoalInteractorOutput.swift
//  CoreDataSample
//
//  Created by lcr on 2020/10/19.
//
import Foundation

protocol GoalListInteractorOutput: AnyObject {
    // Interactorから呼ばれる
    // Interactorがデータの取得に成功/失敗したことの通知
    func failedLoad(error: Error)
    func successLoad(goals: [Goal])
}
