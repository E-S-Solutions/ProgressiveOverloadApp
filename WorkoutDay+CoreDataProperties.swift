//
//  WorkoutDay+CoreDataProperties.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-30.
//
//

import Foundation
import CoreData


extension WorkoutDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutDay> {
        return NSFetchRequest<WorkoutDay>(entityName: "WorkoutDay")
    }

    @NSManaged public var dayOfWeek: String?
    @NSManaged public var exercises: NSSet?
    @NSManaged public var split: WorkoutSplit?

}

// MARK: Generated accessors for exercises
extension WorkoutDay {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}

extension WorkoutDay : Identifiable {

}
