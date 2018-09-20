//
//  SQLiteManager.swift
//  sqltest
//
//  Created by Godjira on 9/18/18.
//  Copyright © 2018 Godjira. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteManager {
    
    private init() {}
    static let shared = SQLiteManager()
    
    var prepsInfo: [PrepInfo]?
    var db: OpaquePointer?
    
    func loadBase() {
        guard let databasePath = Bundle.main.path(forResource: "database.db", ofType: nil) else { return }
        
        if sqlite3_open(databasePath, &db) != SQLITE_OK {
            print("error open db")
            return
        }
        
        prepsInfo = getPrepsInfo()
    }
    
    func getPreps() -> [Prep] {
        var preps = [Prep]()
        let queryString = "SELECT * FROM preps"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return []
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 2))
            let about = String(cString: sqlite3_column_text(stmt, 8)).htmlToAttributedString
            let picture = String(cString: sqlite3_column_text(stmt, 9))

            preps.append(Prep(id: id, name: name, about: about!, picture: picture))
        }
        return preps
    }
    
    func getInfo(prep: Prep) -> [PrepInfo] {
        var prepInfo: [PrepInfo] = []
        
        for prepInf in prepsInfo! where prepInf.prepId == prep.id {
            prepInfo.append(prepInf)
        }
        
        return prepInfo
    }
    
    private func getPrepsInfo() -> [PrepInfo] {
        var prepsInf: [PrepInfo] = []
        let queryString = "SELECT * FROM all_inf_preps"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return []
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let prepId = Int(sqlite3_column_int(stmt, 1))
            let name = String(cString: sqlite3_column_text(stmt, 2))
            let text = String(cString: sqlite3_column_text(stmt, 3))
            let order = Int(sqlite3_column_int(stmt, 4))

            //adding values to list
            let prepInf = PrepInfo(id: id, prepId: prepId, name: name, text: text, orderInfo: order)
            prepsInf.append(prepInf)
        }
        
        return prepsInf
    }
    
}


