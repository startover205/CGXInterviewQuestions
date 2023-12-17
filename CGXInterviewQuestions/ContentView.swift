//
//  ContentView.swift
//  CGXInterviewQuestions
//
//  Created by Ming-Ta Yang on 2023/12/17.
//

import SwiftUI

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
