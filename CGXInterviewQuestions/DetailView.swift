//
//  DetailView.swift
//  CGXInterviewQuestions
//
//  Created by Ming-Ta Yang on 2023/12/17.
//

import SwiftUI

struct DetailView: View {
    let onStartPause: () -> Void
    let percentage: String
    
    var body: some View {
        VStack {
            Button("Start / Pause") {
                onStartPause()
            }
            .buttonStyle(.borderedProminent)
            
            Text(percentage)
        }
    }
}

#Preview {
    DetailView(onStartPause: {}, percentage: "55%")
}
