//
//  ContentView.swift
//  ActorDemo
//
//  Created by Sakir Saiyed on 2025-06-10.
//

import SwiftUI 

struct ContentView: View {
    @StateObject private var viewModel = RateLimiterViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button(action: {
                    viewModel.makeAPICall()
                }) {
                    Text("Make API Call")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                List(viewModel.logs, id: \.self) { log in
                    Text(log)
                        .font(.system(.body, design: .monospaced))
                }

                if let time = viewModel.remainingTime {
                    Text("⏳ Next request in: \(time) sec")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                        .padding(.bottom)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.3), value: time)
                }
            }
            .navigationTitle("Rate Limiter Demo")
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Rate Limited 🚫"),
                      message: Text(viewModel.alertMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}
