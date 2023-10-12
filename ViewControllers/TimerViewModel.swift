//  TimerViewModel.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/13/22.
//
//  This file provides the view model for the TimerView. The TimerViewModel
//  handles the logic and state associated with a countdown timer.

import SwiftUI
import Foundation

extension TimerView {
    
    /// TimerViewModel is an observable object responsible for managing the state and logic of a countdown timer.
    final class TimerViewModel: ObservableObject {
        
        // Indicates if the timer is active or not.
        @Published var isActive = false
        
        // Represents the displayed time in minutes and seconds.
        @Published var time: String = "5:00"
        
        // Represents the total number of minutes set for the timer.
        @Published var minutes: Float = 5.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        
        // Holds the initial set time for the timer.
        private var initialTime = 0
        
        // Represents the end time when the timer is supposed to finish.
        private var endDate = Date()
        
        /// Initiates the timer countdown with the provided minutes.
        ///
        /// - Parameter minutes: The number of minutes to set for the countdown.
        func start(minutes: Float) {
            self.initialTime = Int(minutes)
            self.endDate = Date()
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
        }
        
        /// Resets the timer back to its initial set time.
        func reset() {
            self.minutes = Float(initialTime)
            self.isActive = false
            self.time = "\(Int(minutes)):00"
        }
        
        /// Computes and updates the timer countdown.
        func updateCountdown() {
            guard isActive else { return }
            
            // Calculate the time difference between the current time and the end time.
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            // End the timer if the countdown reaches zero.
            if diff <= 0 {
                self.isActive = false
                self.time = "0:00"
                return
            }
            
            // Convert the time difference to minutes and seconds for display.
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            // Update the displayed time.
            self.minutes = Float(minutes)
            self.time = String(format:"%d:%02d", minutes, seconds)
        }
    }
}
