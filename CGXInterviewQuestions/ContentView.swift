//
//  ContentView.swift
//  CGXInterviewQuestions
//
//  Created by Ming-Ta Yang on 2023/12/17.
//

import SwiftUI

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
    @StateObject private var timerA = TimerViewModel(totalSecond: 60)
    @StateObject private var timerB = TimerViewModel(totalSecond: 90)
    @StateObject private var timerC = TimerViewModel(totalSecond: 120)
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    DetailView(onStartPause: {
                        timerA.startPauseTimer()
                    }, percentage: timerA.progress)
                } label: {
                    Text("Timer A")
                        .frame(width: 200)
                        .overlay(alignment: .trailing) {
                            Text(timerA.progress)
                        }
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink {
                    DetailView(onStartPause: {
                        timerB.startPauseTimer()
                    }, percentage: timerB.progress)
                } label: {
                    Text("Timer B")
                        .frame(width: 200)
                        .overlay(alignment: .trailing) {
                            Text(timerB.progress)
                        }
                }
                .buttonStyle(.borderedProminent)

                NavigationLink {
                    DetailView(onStartPause: {
                        timerC.startPauseTimer()
                    }, percentage: timerC.progress)
                } label: {
                    Text("Timer C")
                        .frame(width: 200)
                        .overlay(alignment: .trailing) {
                            Text(timerC.progress)
                        }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ContentView()
}
