//
//  LogWriteData.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/09.
//

import RealmSwift
import Foundation

class LogWriteData: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var date: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
