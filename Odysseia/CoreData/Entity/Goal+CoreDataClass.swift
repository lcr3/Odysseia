//
//  Goal+CoreDataClass.swift
//  Odysseia
//
//  Created by lcr on 2020/10/30.
//

import Foundation
import CoreData

@objc(Goal)
public class Goal: NSManagedObject {
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}
