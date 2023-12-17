//
//  ContentView.swift
//  CGXInterviewQuestions
//
//  Created by Ming-Ta Yang on 2023/12/17.
//

import SwiftUI

final class TimerViewModel: ObservableObject {
    let totalSecond: Int
    
    @Published private(set) var progress = "0%"
    private var currentSecond = 0 {
        didSet {
            progress = Int((Double(currentSecond) / Double(totalSecond))*100.rounded(.toNearestOrEven)).description + "%"
        }
    }
    
    private var timer: Timer?
    
    init(totalSecond: Int) {
        self.totalSecond = totalSecond
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
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                } label: {
                    Text("Timer A 55%")
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink {
                } label: {
                    Text("Timer B 55%")
                }
                .buttonStyle(.borderedProminent)

                NavigationLink {
                } label: {
                    Text("Timer C 55%")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ContentView()
}
