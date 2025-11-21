//
//  Subscription.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import Foundation

struct Subscription: Codable {
    let id: UUID
    let userId: UUID
    var isActive: Bool
    var startDate: Date
    var endDate: Date?
    var subscriptionType: SubscriptionType
    
    enum SubscriptionType: String, Codable {
        case monthly = "monthly"
        case yearly = "yearly"
        case lifetime = "lifetime"
    }
    
    var isExpired: Bool {
        guard let endDate = endDate else {
            return false // Lifetime subscription
        }
        return Date() > endDate
    }
}

struct Donation: Codable {
    let id: UUID
    let userId: UUID
    let amount: Double
    let date: Date
    var status: DonationStatus
    
    enum DonationStatus: String, Codable {
        case pending = "pending"
        case completed = "completed"
        case failed = "failed"
    }
}

struct BugReport: Codable, Identifiable {
    let id: UUID
    let userId: UUID
    let title: String
    let description: String
    let date: Date
    var status: ReportStatus
    
    enum ReportStatus: String, Codable {
        case pending = "pending"
        case resolved = "resolved"
        case dismissed = "dismissed"
    }
}

struct AcronymSuggestion: Codable, Identifiable {
    let id: UUID
    let userId: UUID
    let acronym: String
    let description: String?
    let date: Date
    var status: SuggestionStatus
    
    enum SuggestionStatus: String, Codable {
        case pending = "pending"
        case approved = "approved"
        case rejected = "rejected"
    }
}





