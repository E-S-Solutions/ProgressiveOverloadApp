//
//  WorkoutSplit+CoreDataProperties.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-30.
//
//

import Foundation
import CoreData


extension WorkoutSplit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutSplit> {
        return NSFetchRequest<WorkoutSplit>(entityName: "WorkoutSplit")
    }

    @NSManaged public var name: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var workoutDays: NSSet?

}

// MARK: Generated accessors for workoutDays
extension WorkoutSplit {

    @objc(addWorkoutDaysObject:)
    @NSManaged public func addToWorkoutDays(_ value: WorkoutDay)

    @objc(removeWorkoutDaysObject:)
    @NSManaged public func removeFromWorkoutDays(_ value: WorkoutDay)

    @objc(addWorkoutDays:)
    @NSManaged public func addToWorkoutDays(_ values: NSSet)

    @objc(removeWorkoutDays:)
    @NSManaged public func removeFromWorkoutDays(_ values: NSSet)

}

extension WorkoutSplit : Identifiable {

}
