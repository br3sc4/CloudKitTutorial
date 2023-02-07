//
//  AddContactView.swift
//  CloudKitTutorial
//
//  Created by Lorenzo Brescanzin on 06/02/23.
//

import SwiftUI

struct AddContactView: View {
    @StateObject private var vm: AddContactViewModel = AddContactViewModel(service: CLoudKitService())
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $vm.name)
            }
            .navigationTitle("Add Contact")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        Task {
                            await vm.save()
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
