//
//  AddMedication.swift
//  Abstract Breathing
//
//  Created by John Nelson on 2/14/22.
//

import SwiftUI

struct AddMedication: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    let onComplete: (String) -> Void
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Medication")) {
                    TextField("Medication Name", text: $name)
                        .onSubmit {
                            onComplete(name)
                        }
                        .submitLabel(.done)
                    Button {
                        onComplete(name)
                    } label: {
                        Text("Add Medication")
                    }
                }
            }
            .toolbar() {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.red)
                })
            }
        }
    }
}

struct AddMedication_Previews: PreviewProvider {
    static var previews: some View {
        AddMedication() {
            name in
            
        }
    }
}
