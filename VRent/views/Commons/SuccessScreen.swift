//
//  SuccessScreen.swift
//  VRent
//
//  Created by Arun R G on 12/08/24.
//

import SwiftUI
import Combine

struct SuccessScreen: View {
    
    
    enum TaskState {
        case inactive
        case inProgress
        case completed
        case failed
    }

    @State private var taskState: TaskState = .inactive
    @State private var rotation: CGFloat = 0
    @State private var redirectionTime = 5
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var timerCanceller: (any Cancellable)?
    
    let task: () async throws -> Void
    
    let onCompletion: () -> Void
    
    
    var body: some View {
        
        VStack {
            Spacer()
            
            markerIcon
                .foregroundStyle(statusColor)
//                .border(Color.black)
                
                .rotation3DEffect(
                    .degrees(rotation),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .onAppear {
                    withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                        rotation += 360
                    }
                }
                .contentTransition(.opacity)
//                .transition(.scale)
                
            
            Spacer()

            Text(statusString)
                .foregroundStyle(statusColor)
                .font(.largeTitle.lowercaseSmallCaps().monospaced().bold())
                .transition(.opacity)
            
            Text(helperText)
                .contentTransition(.numericText(countsDown: true))
                .multilineTextAlignment(.center)
                .font(.callout)

            
            Spacer()
            Spacer()
        }
        .task {
            taskState = .inProgress
            
            var taskIsSuccessful = true
            
            do {
                try await task()
            } catch {
                taskIsSuccessful = false
                print(error)
            }
            
            
            
            withAnimation(.linear(duration: 0.1).repeatCount(4, autoreverses: false)) {
                rotation += 360
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.30) {
                withAnimation(.snappy) {
                    taskState = taskIsSuccessful ? .completed : .failed
                }
            }
            
            timerCanceller = timer.connect()
        }
        .onReceive(timer) { update in
            redirectionTime -= 1
            if(redirectionTime<=0) {
                timerCanceller?.cancel()
                onCompletion()
            }
        }
        
            
    }
    
    var markerIcon: some View {
        ZStack {
            Group {
                Image(systemName: "square")
                    .font(.system(size: 200).weight(.ultraLight))
                    
                Image(systemName: "square")
                    .font(.system(size: 170).weight(.light))
            }
            .rotationEffect(.degrees(45))
            
            switch(taskState) {
                case .inactive:
                    ProgressView()
                case .inProgress:
                    Image(systemName: "questionmark")
                        .font(.system(size: 90))
                case .completed:
                    PinkSlipIcon()
                        .offset(x: -15, y: -5)
                case .failed:
                    Image(systemName: "xmark")
                        .font(.system(size: 90))
            }
            
        }
    }
    
    
    var statusString: String {
        switch(taskState){
            case .inactive: "Please Wait"
            case .inProgress: "Booking In Progress"
            case .completed: "Booked Successfully"
            case .failed: "Booking Failed"
        }
    }
    
    var statusColor: some ShapeStyle {
        
        switch(taskState) {
            case .inactive: AnyShapeStyle(.foreground)
            case .inProgress: AnyShapeStyle(.tint)
            case .completed: AnyShapeStyle(.green)
            case .failed: AnyShapeStyle(.red)
        }
    }
    
    var helperText: String {
        let redirectionMsg = "You will redirected to home in \(redirectionTime) seconds"
        return switch(taskState) {
            case .inactive, .inProgress: "Please Don't Navigate Back or Close the app"
            case .completed: redirectionMsg
            case .failed: "Please try again later\n" + redirectionMsg
        }
    }
}

#Preview {
    enum CustomError: Error {
        case BullShit
    }
    
    return SuccessScreen {
        try await Task.sleep(for: .seconds(8))
//        throw CustomError.BullShit
    } onCompletion: {
        
    }
    
    
}
