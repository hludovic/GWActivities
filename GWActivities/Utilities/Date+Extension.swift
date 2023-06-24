//
//  Date+Extension.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 24/06/2023.
//

import Foundation

extension Date {
    static func dateCreator(year: Int, month: Int, day: Int) -> Date {
        var component: DateComponents = DateComponents()
        component.calendar = .current
        component.year = year
        component.month = month
        component.day = day
        return Calendar.current.date(from: component)!
    }
}
