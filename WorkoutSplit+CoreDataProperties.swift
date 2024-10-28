//
//  WorkoutSplit+CoreDataProperties.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//
//

import Foundation
import CoreData


extension WorkoutSplit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutSplit> {
        return NSFetchRequest<WorkoutSplit>(entityName: "WorkoutSplit")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var exercises: NSSet?

}

// MARK: Generated accessors for exercises
extension WorkoutSplit {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}
