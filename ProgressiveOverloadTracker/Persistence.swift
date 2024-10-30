//  Persistence.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Sample split
        let sampleSplit = WorkoutSplitEntity(context: viewContext)
        sampleSplit.name = "Push/Pull/Legs"
        sampleSplit.creationDate = Date()
        
        // Add sample days and exercises
        let days = ["Monday", "Tuesday", "Wednesday", "Friday", "Saturday", "Sunday"]
        let exercises = [
            ["Bench Press", "Shoulder Press", "Tricep Dips"],
            ["Pull-Up", "Deadlift", "Bicep Curl"],
            ["Squat", "Leg Press", "Calf Raise"],
            ["Bench Press", "Shoulder Fly", "Tricep Extension"],
            ["Lat Pulldown", "Row", "Hammer Curl"],
            ["Leg Extension", "Lunge", "Leg Curl"]
        ]
        
        for (index, day) in days.enumerated() {
            let workoutDay = WorkoutDayEntity(context: viewContext)
            workoutDay.dayOfWeek = day
            workoutDay.split = sampleSplit
            
            for exerciseName in exercises[index] {
                let exercise = ExerciseEntity(context: viewContext)
                exercise.name = exerciseName
                exercise.sets = 3
                exercise.reps = 10
                exercise.weight = 50.0
                exercise.workoutDay = workoutDay // Set relationship to the day
            }
            sampleSplit.addToWorkoutDays(workoutDay)
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ProgressiveOverloadTracker")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    // MARK: - Helper Functions

    func addWorkoutSplit(name: String) {
        let split = WorkoutSplitEntity(context: container.viewContext)
        split.name = name
        split.creationDate = Date()
        saveContext()
    }

    func addWorkoutDay(to split: WorkoutSplitEntity, dayOfWeek: String) {
        let workoutDay = WorkoutDayEntity(context: container.viewContext)
        workoutDay.dayOfWeek = dayOfWeek
        workoutDay.split = split
        saveContext()
    }

    func addExercise(to workoutDay: WorkoutDayEntity, name: String, reps: Int, sets: Int, weight: Double) {
        let exercise = ExerciseEntity(context: container.viewContext)
        exercise.name = name
        exercise.reps = Int16(reps)
        exercise.sets = Int16(sets)
        exercise.weight = weight
        exercise.workoutDay = workoutDay // Set relationship to the day
        saveContext()
    }

    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



