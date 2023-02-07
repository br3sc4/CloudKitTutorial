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
    }
    
    func delete(at indexSet: IndexSet) async {
    }
}
