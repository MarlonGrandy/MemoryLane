//
//  helpers.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/1/22.
//
//  This file defines helper functions that assist in various functionalities of the application.
//  The functions help determine prompts for the user, get specific prompts based on the user's age or timeline,
//  and check if the user is maintaining a recording streak.

import Foundation

/// Determines the prompt index to use based on the current day.
/// Adds 1 to the prompt index at midnight to cycle to a new prompt.
///
/// - Returns: The index for the prompt based on the difference between today's date and a specific start date.
func promptIndex() -> Int {
    let calendar = Calendar.current
    var date = DateComponents()
    date.day = 20
    date.month = 3
    date.year = 2023
    let firstDate = calendar.date(from: date)
    let firstDateNoTime = calendar.dateComponents([.day, .year, .month], from: firstDate!)
    let now = Date()
    let nowDate = calendar.dateComponents([.day, .year, .month], from: now)
    let numberOfDays = calendar.dateComponents([.day], from: firstDateNoTime, to: nowDate)
    return numberOfDays.day!
}

/// Retrieves a specific prompt based on a key (life stage) and an index.
///
/// - Parameters:
///   - key: A string indicating the user's current life stage.
///   - promptIndex: The index of the desired prompt within that life stage.
///
/// - Returns: The prompt as a string.
func getPrompt(key: String, promptIndex: Int) -> String {
    let prompt: [String: [String]] = ["childhood": ["What sights, sounds and smells remind you of your mother/father?", "What were family gatherings like? How often did they happen?", "What, if any, kind of family drama was there when you were growing up?", "What vacations did you take growing up?", "Describe a time when something went completely wrong while traveling."], "teenager": ["Describe your best friend.", "What were your life goals?", "Did you like/dislike school, why?", "What made you unique as a teenager?"], "early adulthood": ["What were your life goals?", "What did you do in your free time?", "Did you like/dislike your job, why?"], "middle adulthood": ["What were your life goals?", "What did you do in your free time?", "Did you like/dislike your job, why?"], "late adulthood": ["What were your life goals?", "What did you do in your free time?", "Did you like/dislike your job, why?"]]
    return prompt[key]![promptIndex]
}

/// Checks if the user has maintained a recording streak by comparing the provided date with the current date.
///
/// - Parameter lastResponseDate: The date of the user's last recording.
///
/// - Returns: A boolean indicating if the user has recorded on the previous day.
func checkStreak(lastResponseDate: Date) -> Bool {
    let calendar = Calendar.current
    let prevDate = calendar.dateComponents([.day, .year, .month], from: lastResponseDate)
    let now = Date()
    let nowDate = calendar.dateComponents([.day, .year, .month], from: now)
    let numberOfDays = calendar.dateComponents([.day], from: prevDate, to: nowDate)
    return numberOfDays.day! == 1
}
