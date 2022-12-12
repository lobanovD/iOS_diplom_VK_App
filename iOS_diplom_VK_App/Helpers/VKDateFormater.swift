//
//  VKDateFormater.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 16.08.2022.
//

import Foundation

// Класс для работы с датами из API

final class VKDateFormater: DateFormatter {
    
    let dateFormater = DateFormatter()
    
    func formateDate(date: Int) -> String {
        dateFormater.locale = Locale(identifier: "ru_RU")
        dateFormater.dateFormat = "d MMM 'в' HH:mm"
        let date = Date(timeIntervalSince1970: Double(date))
        let dateTitle = dateFormater.string(from: date)
        return dateTitle
    }
}
