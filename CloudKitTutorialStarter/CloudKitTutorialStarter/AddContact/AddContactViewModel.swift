//
//  AddContactViewModel.swift
//  CloudKitTutorial
//
//  Created by Lorenzo Brescanzin on 06/02/23.
//

import Foundation

final class AddContactViewModel: ObservableObject {
    @Published var name: String = ""
    
    private let service: CLoudKitService
    
    init(service: CLoudKitService) {
        self.service = service
    }
    
    func save() async {
    }
}
