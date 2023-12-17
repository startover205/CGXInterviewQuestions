//
//  ContentView.swift
//  CGXInterviewQuestions
//
//  Created by Ming-Ta Yang on 2023/12/17.
//

import SwiftUI
import MediaPlayer

final class TimerViewModel: ObservableObject {
    let totalSecond: Int
    let onProgressChange: ((Double) -> Void)?
    
    @Published private(set) var progress = "0%"
    private var currentSecond = 0 {
        didSet {
            onProgressChange?(Double(currentSecond) / Double(totalSecond))
            progress = Int((Double(currentSecond) / Double(totalSecond))*100.rounded(.toNearestOrEven)).description + "%"
        }
    }
    
    private var timer: Timer?
    
    init(totalSecond: Int, onProgressChange: ((Double) -> Void)? = nil) {
        self.totalSecond = totalSecond
        self.onProgressChange = onProgressChange
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func startPauseTimer() {
        guard currentSecond < totalSecond else { return }
        
        if let timer {
            timer.invalidate()
            self.timer = nil
        } else {
            timer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
                guard let self else { return }
                
                currentSecond += 1
                
                if currentSecond >= totalSecond {
                    timer.invalidate()
                    self.timer = nil
                }
            })
        }
    }
}

struct ContentView: View {
    @StateObject private var timerA = TimerViewModel(totalSecond: 60) { progress in
        if progress > 0.2 {
            // darkness level
            UIScreen.main.brightness = (1-CGFloat(progress))
        }
    }
    @StateObject private var timerB = TimerViewModel(totalSecond: 90) {
        progress in
        MPVolumeView.setVolume(Float(progress))
    }
    @StateObject private var timerC = TimerViewModel(totalSecond: 120)
    
    var body: some View {
        NavigationStack {
            VStack {
                TimerButtonView(timer: timerA, title: "Timer A")
                TimerButtonView(timer: timerB, title: "Timer B")
                TimerButtonView(timer: timerC, title: "Timer C")
            }
        }
    }
    
    struct TimerButtonView: View {
        @ObservedObject var timer: TimerViewModel
        let title: String
        
        var body: some View {
            NavigationLink {
                DetailView(onStartPause: {
                    timer.startPauseTimer()
                }, percentage: timer.progress)
            } label: {
                Text(title)
                    .frame(width: 200)
                    .overlay(alignment: .trailing) {
                        Text(timer.progress)
                    }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
