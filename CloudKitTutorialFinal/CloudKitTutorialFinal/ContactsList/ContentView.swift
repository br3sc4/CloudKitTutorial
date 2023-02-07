//
//  ContentView.swift
//  CloudKitTutorial
//
//  Created by Lorenzo Brescanzin on 06/02/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm: ContactsListViewModel = ContactsListViewModel(service: CLoudKitService())
    @State private var showAddContactModal: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.contacts) { contact in
                    Text(contact.name)
                }
                .onDelete { indexSet in
                    Task {
                        await vm.delete(at: indexSet)
                    }
                }
            }
            .refreshable(action: vm.fetchContacts)
            .task {
                await vm.fetchContacts()
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddContactModal.toggle()
                    } label: {
                        Label("Add Contact", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showAddContactModal) {
            AddContactView()
                .presentationDetents([.medium])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
