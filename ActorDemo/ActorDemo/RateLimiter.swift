//
//  RateLimiter.swift
//  ActorDemo
//
//  Created by Sakir Saiyed on 2025-06-10.
//

import Foundation

import Foundation

actor RateLimiter {
    private let maxRequests: Int
    private let interval: TimeInterval
    private var requestTimestamps: [Date] = []

    init(maxRequests: Int, per interval: TimeInterval) {
        self.maxRequests = maxRequests
        self.interval = interval
    }

    func allowRequest() -> (allowed: Bool, waitTime: TimeInterval?) {
        let now = Date()
        requestTimestamps = requestTimestamps.filter { now.timeIntervalSince($0) < interval }

        if requestTimestamps.count < maxRequests {
            requestTimestamps.append(now)
            return (true, nil)
        } else {
            let earliest = requestTimestamps.min()!
            let wait = interval - now.timeIntervalSince(earliest)
            return (false, wait)
        }
    }
    
    func timeUntilNextAllowed() -> TimeInterval? {
        let now = Date()
        requestTimestamps = requestTimestamps.filter { now.timeIntervalSince($0) < interval }

        if requestTimestamps.count < maxRequests {
            return nil
        } else {
            let earliest = requestTimestamps.min()!
            return max(0, interval - now.timeIntervalSince(earliest))
        }
    }
}
