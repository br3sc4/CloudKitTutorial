//
//  ContactsListViewModel.swift
//  CloudKitTutorial
//
//  Created by Lorenzo Brescanzin on 06/02/23.
//

import Foundation

final class ContactsListViewModel: ObservableObject {
    @Published private(set) var contacts: [Contact] = []
    
    private let service: CLoudKitService
    
    init(service: CLoudKitService) {
        self.service = service
        
        Task {
            await fetchContacts()
        }
    }
    
    @MainActor
    @Sendable func fetchContacts() async {
        do {
            contacts = try await service.fetch(recordType: "Contact")
        } catch {
            debugPrint(error)
        }
    }
    
    func delete(at indexSet: IndexSet) async {
        do {
            guard let index = indexSet.first else { return }
            try await service.delete(recordID: contacts[index].id)
        } catch {
            debugPrint(error)
        }
    }
}
