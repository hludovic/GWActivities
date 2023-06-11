//
//  Activities.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 10/06/2023.
//

import Foundation

enum Activities: Int, CaseIterable, Identifiable {
  case daily, weekly, monthly, events

  var id: Int { self.rawValue }

  var name: String {
    switch self {
    case .daily: return "Daily activities"
    case .weekly: return "Weekly activities"
    case .monthly: return "Monthly activities"
    case .events: return "Events"
    }
  }
}
