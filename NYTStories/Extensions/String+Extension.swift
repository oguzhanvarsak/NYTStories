//
//  String+Extension.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 22.05.2022.
//

import Foundation

extension String {
    func getDate() -> String {
        let dateFormatter = Formatter.dateFormatter
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let date = dateFormatter.date(from:(self))
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date ?? Date())
        
        let finalDate = calendar.date(from:components)
        
        dateFormatter.dateFormat = "dd MMM, YYYY"
        
        return dateFormatter.string(from: finalDate!)
    }
}
