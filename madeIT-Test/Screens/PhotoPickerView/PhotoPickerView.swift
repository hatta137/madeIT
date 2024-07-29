//
//  PhotoPickerView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 27.07.24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct PhotoPickerView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var image: UIImage?
    
    @State private var name: String = ""
    @State private var notes: String = ""
    @State private var imageData: Data?
    @State private var customer: Customer? = nil
    
    @Query var customers: [Customer]
    
    @FocusState private var focusedTextField: FormTextField?
    
    enum FormTextField {
        case name, notes
    }
    
    
    var body: some View {
        VStack {
            Form {
                customerInformationSection
                
                Section("Grafikinformationen") {
                    TextField("Name", text: $name)
                        .focused($focusedTextField, equals: .name)
                        .onSubmit { focusedTextField = .notes }
                        .submitLabel(.next)
                    
                    TextField("Notiz", text: $notes)
                        .focused($focusedTextField, equals: .notes)
                        .onSubmit { focusedTextField = nil }
                        .submitLabel(.continue)
                    
                    
                }
                
                Section {
                    PhotosPicker(selection: $photosPickerItem) {
                        if let uiImage = image {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 300)
                        } else {
                            Text("Kein Bild gewählt")
                                .foregroundColor(.gray)
                                .frame(width: 300, height: 300)
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(10)
                        }
                    }
                }
                
                Section {
                    Button("Grafik speichern") {
                        guard let imageData = imageData else {
                            print("Fehler: Kein Bild ausgewählt")
                            return
                        }
                        
                        let graphic = Attachment(name: name, notes: notes, attachmentData: imageData, customer: customer)
                        
                        do {
                            try modelContext.insert(graphic)
                            try modelContext.save()
                            resetForm()
                            dismiss()
                        } catch {
                            // Fehlerbehandlung: Zeigen Sie eine Meldung an oder loggen Sie den Fehler
                            print("Fehler beim Speichern der Grafik: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        .onChange(of: photosPickerItem) { _, _ in
            
            Task {
                if let photosPickerItem,
                   let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let imageFromData = UIImage(data: data) {
                        imageData = data
                        image = imageFromData
                    }
                }
            }
        }
    }
    
    private var customerInformationSection: some View {
        Section("Kundeninformation") {
            Picker("Kunde", selection: $customer) {
                Text("Wähle einen Kunden").tag(Customer?.none)
                ForEach(customers, id: \.self) { customer in
                    Text(customer.name).tag(customer as Customer?)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    private func resetForm() {
        name = ""
        notes = ""
        imageData = Data()
    }
}

//#Preview {
//    PhotoPickerView()
//}
