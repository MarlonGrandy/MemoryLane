//  TimerView.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/13/22.
//  This file crafts a visual representation of a timer, with controls and prompts. The underlying timer logic is managed by TimerViewModel.

import SwiftUI

// TimerView defines the UI and behavior for a reflection timer.
struct TimerView: View {
    
    // A state object that manages the timer's internal behavior.
    @StateObject private var viewControl = TimerViewModel()
    
    // Timer configuration to update the UI every second.
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // State properties to manage UI animations and behaviors.
    @State private var animateGradient: Bool = true
    @State private var started = false
    @Binding var viewPicker: Int
    @State private var animate: Bool = false
    @AppStorage("color pick") private var colorPicked = "starry sky"
    
    // Animation configuration for a linear, endlessly repeating animation.
    let animation: Animation = Animation.linear(duration: 10.0).repeatForever(autoreverses: false)
    
    var body: some View {
        ZStack{
            
            // Dynamic background to create a moving visual effect.
            GeometryReader { geo in
                HStack(spacing: -1) {
                    Image(colorPicked)
                        .resizable()
                        .scaledToFill()
                    Image(colorPicked)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, alignment: .leading)
                }
                .frame(width: geo.size.width, height: geo.size.height,
                       alignment: animate ? .trailing : .leading)
            }
            .ignoresSafeArea()
            .onAppear {
                withAnimation(animation) {
                    animate.toggle()
                }
            }
            
            VStack {
                Spacer()
                
                // Prompt text for user reflection.
                Text("Reflect on today's prompt for five minutes and record your daily memory.")
                    .foregroundColor(Color.white)
                    .opacity(0.5)
                    .font(.system(size: 20, weight: .medium, design: .serif))
                    .multilineTextAlignment(.center)
                
                Divider()
                    .background(Color.white)
                
                // Displays the current timer value.
                Text("\(viewControl.time)")
                    .foregroundColor(Color.white)
                    .font(.system(size: 150, weight: .medium, design: .serif))
                    .background(.clear)
                    .opacity(1)
                
                // Start/Stop button based on timer's state.
                Button{
                    if started == false {
                        viewControl.start(minutes: viewControl.minutes)
                        started = true
                    } else {
                        viewControl.reset()
                        started = false
                    }
                }label:{
                    if started == false {
                        Text("Start")
                            .font(.system(size: 32, weight: .medium, design: .serif))
                            .foregroundColor(Color.white)
                            .opacity(0.5)
                    } else {
                        Text("Stop")
                            .font(.system(size: 32, weight: .medium, design: .serif))
                            .foregroundColor(Color.white)
                            .opacity(0.5)
                    }
                }
                
                // Integrates the ControlBarView for navigation.
                ControlBarView(viewPicker: $viewPicker)
                    .padding(.top,190)
                
            }
            // Updates the timer countdown every second.
            .onReceive(timer) { _ in
                viewControl.updateCountdown()
            }
        }
    }
}

// Preview setup for design and layout purposes.
struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewPicker: .constant(1))
    }
}
