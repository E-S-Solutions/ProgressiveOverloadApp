//
//  Exercise+CoreDataProperties.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var reps: Int16
    @NSManaged public var sets: Int16
    @NSManaged public var weight: Double
    @NSManaged public var workoutSplit: WorkoutSplit?

}
