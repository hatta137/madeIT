//
//  NewModal.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI

enum PickerType: Identifiable {
    case photo, file
    
    var id: Int {
        hashValue
    }
}

struct NewModalView: View {
    @State private var actionSheetVisible = false
    @State private var showPhotoPicker = false
    @State private var showFileImporter = false
    @State private var pickerType: PickerType?
    @State var fileURL: URL?
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: NewCustomerView()) {
                    Text("Kunde anlegen")
                }
                NavigationLink(destination: NewResourceView()) {
                    Text("Resource anlegen")
                }
                Button("Anhang hinzufügen") {
                    self.actionSheetVisible = true
                }
            }
            .navigationTitle("🆕 Neu anlegen")
            .navigationBarTitleDisplayMode(.inline)
            .actionSheet(isPresented: $actionSheetVisible) {
                ActionSheet(
                    title: Text("Wählen Sie eine Option"),
                    buttons: [
                        .default(Text("Foto auswählen")) {
                            pickerType = .photo
                        },
                        .default(Text("Datei auswählen")) {
                            pickerType = .file
                        },
                        .cancel()
                    ]
                )
            }
            .sheet(item: $pickerType) { picker in
                if picker == .photo {
                    PhotoPickerView()
                } else if picker == .file {
                    DocumentPickerView(fileURL: $fileURL)
                }
            }
        }
    }
}
//
//#Preview {
//    NewModalView()
//}
