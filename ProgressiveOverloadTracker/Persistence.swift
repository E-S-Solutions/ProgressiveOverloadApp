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
        for _ in 0..<10 {
            let newSplit = WorkoutSplit(context: viewContext)
            newSplit.name = "Sample Split"
            newSplit.creationDate = Date()
            
            let newExercise = Exercise(context: viewContext)
            newExercise.name = "Sample Exercise"
            newExercise.reps = 10
            newExercise.sets = 3
            newExercise.weight = 50.0
            newExercise.date = Date()
            
            newSplit.addToExercises(newExercise)
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
        let split = WorkoutSplit(context: container.viewContext)
        split.name = name
        split.creationDate = Date()
        saveContext()
    }

    func addExercise(to split: WorkoutSplit, name: String, reps: Int, sets: Int, weight: Double) {
        let exercise = Exercise(context: container.viewContext)
        exercise.name = name
        exercise.reps = Int16(reps)
        exercise.sets = Int16(sets)
        exercise.weight = weight
        exercise.date = Date()
        split.addToExercises(exercise)
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


