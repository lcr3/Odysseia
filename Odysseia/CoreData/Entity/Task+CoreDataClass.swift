//
//  Task+CoreDataClass.swift
//  Odysseia
//
//  Created by lcr on 2020/10/30.
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    public static let maxTargetCount = 999
    public static let minTargetCount = 1
}
