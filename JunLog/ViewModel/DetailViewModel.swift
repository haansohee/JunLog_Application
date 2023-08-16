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
    
    func uploadLog(title: String, content: String, date: Date) {
        if title.isEmpty {
            logWirteData.title = "제목없음"
        } else {
            logWirteData.title = title
        }
        
        if content.isEmpty {
            logWirteData.content = "내용없음"
        } else {
            logWirteData.content = content
        }
        
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date = dateFormatter.string(from: date)
        
        // make ID
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        guard let id = Int(dateFormatter.string(from: Date())) else { return print("id ERror")}
        
        logWirteData.date = date
        logWirteData.id = id
        
        try! realm.write {
            realm.add(logWirteData)
        }
    }
}
