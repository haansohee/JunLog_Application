//
//  MainTableViewModel.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/14.
//

import Foundation
import RealmSwift
import RxSwift

final class MainTableViewModel {
    private let realm = try! Realm()
    private(set) var logWriteData: [LogWriteData] = []
    private var sortSet = false
    private var asc = false
    
    private func sortDate(asc: Bool) {
        if asc {
            let dataList = realm.objects(LogWriteData.self).sorted(byKeyPath: "date", ascending: false)
            self.logWriteData = Array(dataList)
        } else {
            let dataList = realm.objects(LogWriteData.self).sorted(byKeyPath: "date", ascending: true)
            self.logWriteData = Array(dataList)
        }
    }
    
    func getData(sortSet: Bool? = nil, asc: Bool? = nil) {
        if let sort = sortSet {
            self.sortSet = sort
        }
        
        if let asc = asc {
            self.asc = asc
        }
        
        switch self.sortSet {
        case true:
            self.sortDate(asc: self.asc)
            
        case false:
            if self.sortSet {
                self.sortDate(asc: self.asc)
            }
            
            let dataList = realm.objects(LogWriteData.self)
            self.logWriteData = Array(dataList)
        }
    }
    
    func deleteData(indexPath: IndexPath) {
        try! realm.write {
            realm.delete(logWriteData[indexPath.row])
        }
        
        logWriteData.remove(at: indexPath.row)
    }
}
