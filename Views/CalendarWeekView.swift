//
//  CalendarWeekView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-30.
//

// CalendarWeekView.swift

import SwiftUI

struct CalendarWeekView: View {
    @Binding var selectedDate: Date
    var workoutDays: [WorkoutDay]

    var body: some View {
        HStack {
            ForEach(workoutDays, id: \.dayOfWeek) { day in
                VStack {
                    Text(day.dayOfWeek)
                        .font(.caption)
                        .foregroundColor(isToday(day.dayOfWeek) ? .blue : .primary)
                        .bold(isToday(day.dayOfWeek))
                    
                    Circle()
                        .fill(isToday(day.dayOfWeek) ? Color.blue : Color.gray.opacity(0.2))
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text(day.dayOfWeek.prefix(1)) // First letter of the day
                                .foregroundColor(.white)
                        )
                        .onTapGesture {
                            selectDay(day.dayOfWeek)
                        }
                }
            }
        }
    }
    
    // Helper function to check if a day is today
    func isToday(_ day: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let todayString = formatter.string(from: Date())
        return todayString == day
    }
    
    // Update selected date based on the tapped day
    func selectDay(_ day: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        if let date = formatter.date(from: day) {
            selectedDate = date
        }
    }
}
