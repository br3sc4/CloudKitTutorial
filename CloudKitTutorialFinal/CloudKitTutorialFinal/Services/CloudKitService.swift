//
//  CloudKitService.swift
//  CloudKitTutorial
//
//  Created by Lorenzo Brescanzin on 06/02/23.
//

import Foundation
import CloudKit

final class CLoudKitService {
    private let container = CKContainer.default()
        
    func fetch<T: CloudKitUploadable>(recordType: CKRecord.RecordType, resultLimits: Int? = nil) async throws -> [T] {
        
        let query = makeQuery(recordType: recordType)
        
        let result = try await container.privateCloudDatabase.records(matching: query)
        let records = result.matchResults.compactMap { try? $0.1.get() }
        return records.compactMap(T.init)
    }
    

    private func makeQuery(recordType: CKRecord.RecordType) -> CKQuery {
        let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
        
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        return query
    }
    
    @discardableResult
    func save<T: CloudKitUploadable>(item: T) async throws -> CKRecord {
        do {
            return try await container.privateCloudDatabase.save(item.record)
        } catch {
            debugPrint("error add \(error.localizedDescription)")
            throw error
        }
    }
    
    func delete(recordID: CKRecord.ID) async throws {
        _ = try await container.privateCloudDatabase.deleteRecord(withID: recordID)
    }
}
