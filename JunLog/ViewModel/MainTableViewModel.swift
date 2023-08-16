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
    
    func getData() {
        let dataList = realm.objects(LogWriteData.self)
        self.logWriteData = Array(dataList)
        
        print("🔹loadData: \(logWriteData)")
    }
    
    func deleteData(indexPath: IndexPath) {
        print(logWriteData)
        print("modelView의 IndexPath.row: \(indexPath.row)")
        
//        print(logWriteData[indexPath.row])
        
        try! realm.write {
            realm.delete(logWriteData[indexPath.row])
        }
        
        logWriteData.remove(at: indexPath.row)
    }
}
