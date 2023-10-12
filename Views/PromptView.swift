//  PromptView.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/12/22.
//File creates the prompt view where users archive memories, view the current prompt, view the quote of the day, and view reflection analytics.

import SwiftUI
import PhotosUI



//  PromptView.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/12/22.
//
//  This file defines the main view for archiving memories. It allows users to view
//  the current prompt, see the quote of the day, and access reflection analytics.

import SwiftUI
import PhotosUI

@available(iOS 16.0, *)
struct PromptView: View {
    
    // Initialization to set default appearance of UITextView
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    // Core Data Context
    @Environment(\.managedObjectContext) var managedObjContext
    
    // Dismiss environment variable
    @Environment(\.dismiss) var dismiss
    
    // Fetch request for daily prompts, sorted by date in descending order
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var mem: FetchedResults<DailyPrompt>
    
    // State properties
    @State private var index: Int = 0
    @State private var response = ""
    @State var items: [String] = ["Date", "Memories", "Streak", "Last Entry"]
    @State var titleValues: [String] = ["1", "2", "3", "4"]
    @State var viewPicker: Int = 3
    @State var selectedPhotoData: Data?
    @State var date: String = "\(Date().get(.month))/\(Date().get(.day))"
    @State var key_val: [String: Int] = ["childhood": 0, "teenager": 0, "early adulthood": 0, "middle adulthood": 0, "late adulthood": 0]
    
    // App storage properties for storing user's data
    @AppStorage("isSubmitted") private var isSubmitted = false
    @AppStorage("memoryValue") var memoryValue = 0
    @AppStorage("childhood") var childIndex = 0
    @AppStorage("teenager") var teenIndex = 0
    @AppStorage("early adulthood") var earlyIndex = 0
    @AppStorage("middle adulthood") var midIndex = 0
    @AppStorage("late adulthood") var lateIndex = 0
    @AppStorage("streakValue") var streakValue = 0
    @AppStorage("indexChecker") private var indexChecker = 0
    @AppStorage("keyValue") var dictKey = "childhood"
    @AppStorage("color pick") var colorPicked = "starry sky"
    
    // Computed property to get the current prompt based on the selected key and index
    var Prompt: String {
        get {
            return getPrompt(key: dictKey, promptIndex: index)
        }
    }
    
    // Body of the view
    var body: some View {
        if viewPicker == 1{
            TimerView(viewPicker: $viewPicker)
        }
        else if viewPicker == 2{
            MemoriesView(viewPicker: $viewPicker)
        }else if viewPicker == 4{
            SettingView(viewPicker: $viewPicker)
        }else if viewPicker == 3{
            
            ZStack {
                VStack{
                    HStack(spacing: 15) {
                        
                        DateView(title: "Date", titleValues: $date)
                        NumberView(title: "Memories", titleValues: $memoryValue)
                        NumberView(title: "Streak", titleValues: $streakValue)
                        
                    }.opacity(0.9)
                    
                    
                    Spacer()
                    Spacer()
                    Group{
                        ZStack{
                            
                            VStack{
                                
                                Text("Daily Inspiration")
                                    .font(.system(size: 24, weight: .regular, design: .serif))
                                    .foregroundColor(Color.white)
                                Divider()
                                    .frame(height: 1)
                                    .overlay(Color.black)
                                Text("Memories are like antiques, the older they are the more valuable they became. – Marinela Reka")
                                    .font(.system(size: 24, weight: .regular, design: .serif))
                                
                                
                                
                                
                            }.padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous).fill(
                                        Color(.sRGB, red: 154/255, green: 173/255, blue: 194/255)
                                    )
                                    .padding(4)
                                    .padding(.leading,3)
                                    .padding(.trailing,3)
                                    .opacity(0.4))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .strokeBorder(Color.white, lineWidth: 1)
                                        .padding(4)
                                        .padding(.leading,3)
                                        .padding(.trailing,3)
                                        .opacity(0.4))
                            
                        }
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                            
                                .foregroundColor(Color(.sRGB, red: 154/255, green: 173/255, blue: 194/255))
                                .opacity(0.4)
                                .padding(4)
                                .padding(.leading,3)
                                .padding(.trailing,3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .strokeBorder(Color.white, lineWidth: 1)
                                        .padding(4)
                                        .padding(.leading,3)
                                        .padding(.trailing,3)
                                        .opacity(0.4))
                            
                            
                            VStack{
                                Text("\(Prompt)")
                                    .font(.system(size: 20, weight: .regular, design: .serif))
                                    .minimumScaleFactor(0.01)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(4)
                                    .padding(.top,5)
                                    .foregroundColor(Color.white)
                                
                                Spacer()
                                if !isSubmitted{
                                    TextEditor(text: $response)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 24, weight: .regular, design: .serif))
                                        .clipShape(RoundedRectangle(cornerRadius:15))
                                        .customTextField()
                                        .shadow(radius: 1.0)
                                        .background(Color.clear)
                                        .opacity(0.75)
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                } else{
                                    ScrollView(.vertical){
                                        Text(mem[0].memory!)
                                            .font(.system(size: 24, weight: .regular, design: .serif))
                                            .padding(.bottom,250)
                                    }
                                }
                                
                                if !isSubmitted{
                                    HStack{
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Button{
                                            DataController().newMemory(memories: response, prompt: Prompt,is_daily: true,img: selectedPhotoData ?? Data("QuickFix".utf8) ,context: managedObjContext)
                                            memoryValue = memoryValue + 1
                                            onSubmit()
                                            isSubmitted = true
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                        } label:{
                                            
                                            Text("Archive\nMemory")
                                                .font(.system(size: 20, weight: .semibold, design: .serif))
                                                .foregroundColor(Color.black)
                                                .opacity(0.75)
                                            
                                        }
                                        .padding(.trailing,40)
                                        ActionList(selectedPhotoData: $selectedPhotoData, currentPrompt: Prompt)
                                        
                                        
                                        Spacer()
                                        
                                        
                                    }
                                }else{
                                    Text("")
                                    
                                }
                                
                                
                            }.padding()
                        }
                        
                        ControlBarView(viewPicker: $viewPicker)
                            .padding(.top,10)
                        
                    }
                } .onAppear{
                    response = "\(dictKey) reflection"
                    dayChange()
                    index = key_val["childhood"]!
                    key_val["childhood"] = childIndex
                    key_val["teenager"] = teenIndex
                    key_val["early adulthood"] = earlyIndex
                    key_val["middle adulthood"] = midIndex
                    key_val["late adulthood"] = lateIndex
                    index = key_val[dictKey]!
                    
                } .fullBackground(imageName: colorPicked)
                
            }
            
        }
    }
    
    // Helper functions used in the view
    
    // This function checks if the current day has changed and adjusts
    // several indices and values accordingly.
    private func dayChange() {
        if indexChecker == index {
            print("Same day!")
        } else {
            isSubmitted = false
            key_val[dictKey]! += 1
            childIndex = key_val["childhood"]!
            teenIndex = key_val["teenager"]!
            earlyIndex = key_val["early adulthood"]!
            midIndex = key_val["middle adulthood"]!
            lateIndex = key_val["late adulthood"]!
            indexChecker = index
        }
    }
    
    // This function handles the submission logic, mainly checking and updating
    // a streak value based on the last response date.
    private func onSubmit() {
        let lastDate = mem[1]
        if mem.count == 0 {
            streakValue += 1
        } else {
            if checkStreak(lastResponseDate: lastDate.date!) {
                streakValue += 1
            } else {
                streakValue = 0
            }
        }
    }
    
    // This function retrieves the date of the last memory.
    // If there are no memories, it returns "N/A".
    private func lastMemoryDate() -> String {
        if mem.count == 0 {
            return "N/A"
        } else {
            return "\(mem[0].date!.get(.month))/\(mem[0].date!.get(.day))"
        }
    }
}
    
    // Extensions used in the view
    
    // Extension for a View to round specific corners with a given radius.
    extension View {
        func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
            clipShape(RoundedCorner(radius: radius, corners: corners))
        }
    }
    
    // Extension for a View to set a full-screen background image.
    public extension View {
        func fullBackground(imageName: String) -> some View {
            return background(
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
        }
    }
    
    // Preview of the design for PromptView on iOS 16.0 or newer.
    @available(iOS 16.0, *)
    struct MyDesign_Previews: PreviewProvider {
        static var previews: some View {
            PromptView()
        }
    }
    
    // Extension for the Date class to retrieve specific components of the date.
    extension Date {
        func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
            return calendar.dateComponents(Set(components), from: self)
        }
        
        func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
            return calendar.component(component, from: self)
        }
    }
