//
//  DateExtension.swift
//  Recipe
//
//  Created by Akhrorkhuja on 18/05/22.
//

import Foundation

extension Date {
    var converToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, dd/MM/yy"
        let str = formatter.string(from: self)
        return str
    }
}
