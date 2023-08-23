//
//  DetailViewModel.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/14.
//

import Foundation
import RealmSwift

final class DetailViewModel {
    private var logWriteData = LogWriteData()
    private let realm = try! Realm()
    private let dateFormatter = DateFormatter()
    
    func convertStringToDate(date: String) -> Date {
        dateFormatter.dateFormat = "yyyy/MM/dd"
        guard let date = dateFormatter.date(from: date) else { return Date() }
        
        return date
    }
    
    private func convertDateToString(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
    private func test(junLogContent: JunLogContent) {
        if junLogContent.title.isEmpty || (junLogContent.title == junLogContent.titlePlaceholder){
            logWriteData.title = "제목없음"
        } else {
            logWriteData.title = junLogContent.title
        }
        
        if junLogContent.content.isEmpty || (junLogContent.content == junLogContent.contentPlaceholder) {
            logWriteData.content = "내용없음"
        } else {
            logWriteData.content = junLogContent.content
        }
        
        let date = convertDateToString(date: junLogContent.date)
        logWriteData.date = date
    }
    
    func uploadLog(with junLogContent: JunLogContent) {
        test(junLogContent: junLogContent)
        
        // make ID
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        guard let id = Int(dateFormatter.string(from: Date())) else { return print("ID ERROR") }
        logWriteData.id = id
        
        try! realm.write {
            realm.add(logWriteData)
        }
    }
    
    func updateLog(with junLogContent: JunLogContent, id: Int) {
        test(junLogContent: junLogContent)
        
        if let object = realm.objects(LogWriteData.self).filter("id = \(id)").first {
            try! realm.write {
                object.title = logWriteData.title
                object.content = logWriteData.content
                object.date = logWriteData.date
            }
        }
    }
}
