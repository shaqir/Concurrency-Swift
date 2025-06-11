//
//  RateLimiterViewModel.swift
//  ActorDemo
//
//  Created by Sakir Saiyed on 2025-06-10.
//

import Foundation
import SwiftUI

@MainActor
class RateLimiterViewModel: ObservableObject {
    @Published var logs: [String] = []
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var remainingTime: Int? = nil

    private let limiter = RateLimiter(maxRequests: 3, per: 10)
    private var requestCount = 1
    private var timer: Timer?
    private var pendingRequest = false

    func makeAPICall() {
        Task {
            let result = await limiter.allowRequest()
            let timestamp = formattedDate()

            if result.allowed {
                logs.insert("✅ Request \(requestCount) allowed at \(timestamp)", at: 0)
                requestCount += 1
                pendingRequest = false
                withAnimation {
                    remainingTime = nil
                }
                stopTimer()
            } else {
                let wait = Int(ceil(result.waitTime ?? 0))
                alertMessage = "Too many requests. Try again in \(wait) seconds."
                showAlert = true
                logs.insert("❌ Request \(requestCount) denied at \(timestamp)", at: 0)
                pendingRequest = true
                startTimer()
            }
        }
    }

    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            Task { [weak self] in
                guard let self else { return }

                if let time = await limiter.timeUntilNextAllowed() {
                    let seconds = Int(ceil(time))
                    await MainActor.run {
                        withAnimation {
                            self.remainingTime = max(0, seconds)
                        }
                    }
                } else {
                    await MainActor.run {
                        withAnimation {
                            self.remainingTime = nil
                        }
                        self.stopTimer()
                        if self.pendingRequest {
                            self.makeAPICall() // 🔁 Auto-retry last denied request
                        }
                    }
                }
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: Date())
    }
}
