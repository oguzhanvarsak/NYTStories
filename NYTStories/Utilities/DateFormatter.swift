//
//  DateFormatter.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import UIKit
import Foundation

class Formatter {
    func getDate(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let date = dateFormatter.date(from:(dateString))
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date ?? Date())
        
        let finalDate = calendar.date(from:components)
        
        dateFormatter.dateFormat = "dd MMM, YYYY"
        
        return dateFormatter.string(from: finalDate!)
    }
}
