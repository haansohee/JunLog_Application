//
//  DetailViewModel.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/14.
//

import Foundation
import RealmSwift

final class DetailViewModel {
    private var logWirteData = LogWriteData()
    private let realm = try! Realm()
    private let dateFormatter = DateFormatter()
    
    func convertStringToDate(date: String) -> Date {
        dateFormatter.dateFormat = "yyyy/MM/dd"
        guard let date = dateFormatter.date(from: date) else { return Date() }
        
        return date
    }
    
    func converDateToString(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
    func uploadLog(with junLogContent: JunLogContent) {
        if junLogContent.title.isEmpty || (junLogContent.title == junLogContent.titlePlaceholder){
            logWirteData.title = "제목없음"
        } else {
            logWirteData.title = junLogContent.title
        }
        
        if junLogContent.content.isEmpty || (junLogContent.content == junLogContent.contentPlaceholder) {
            logWirteData.content = "내용없음"
        } else {
            logWirteData.content = junLogContent.content
        }
        
        let date = converDateToString(date: junLogContent.date)
        
        // make ID
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        guard let id = Int(dateFormatter.string(from: Date())) else { return print("id ERror") }
        
        logWirteData.date = date
        logWirteData.id = id
        
        try! realm.write {
            realm.add(logWirteData)
        }
    }
    
    func updateLog(with junLogContent: JunLogContent, id: Int) {
    }
}
